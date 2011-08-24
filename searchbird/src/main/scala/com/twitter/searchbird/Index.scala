package com.twitter.searchbird

import scala.collection.mutable
import org.apache.thrift.protocol.TBinaryProtocol

import com.twitter.util._
import com.twitter.conversions.time._
import com.twitter.logging.Logger
import com.twitter.finagle.builder.ClientBuilder
import com.twitter.finagle.thrift.ThriftClientFramedCodec


trait Index {
  def get(key: String): Future[String]
  def put(key: String, value: String): Future[Unit]
  def search(key: String): Future[List[String]]
}

class ResidentIndex extends Index {
  val log = Logger.get(getClass)

  val forward = new mutable.HashMap[String, String]
    with mutable.SynchronizedMap[String, String]
  val reverse = new mutable.HashMap[String, Set[String]]
    with mutable.SynchronizedMap[String, Set[String]]

  def get(key: String) = {
    forward.get(key) match {
      case None =>
        log.debug("get %s: miss", key)
        Future.exception(new SearchbirdException("No such key"))
      case Some(value) =>
        log.debug("get %s: hit", key)
        Future(value)
    }
  }

  def put(key: String, value: String) = {
    log.debug("put %s", key)
    
    forward(key) = value

    // admit only one updater.
    synchronized {
      (Set() ++ value.split(" ")) foreach { token =>
        val current = reverse.get(token) getOrElse Set()
        reverse(token) = current + key
      }
    }

    Future.Unit
  }

  def search(query: String) = Future.value {
    val tokens = query.split(" ")
    val hits = tokens map { token => reverse.getOrElse(token, Set()) }
    val intersected = hits reduceLeftOption { _ & _ } getOrElse Set()
    intersected.toList
  }
}

class CompositeIndex(indices: Seq[Index]) extends Index {
  require(!indices.isEmpty)

  def get(key: String) = try {
    println("GET", key)
    val queries = indices.map { idx =>
      idx.get(key) map { r => Some(r) } handle { case e => None }
    }

    Future.collect(queries) flatMap { results =>
      println("got results", results.mkString(","))
      results.find { _.isDefined } map { _.get } match {
        case Some(v) => Future.value(v)
        case None => Future.exception(new SearchbirdException("No such key"))
      }
    }
  } catch {
    case e => 
      println("got exc", e)
      throw e
  }

  def put(key: String, value: String) =
    Future.exception(new SearchbirdException("put() not supported by CompositeIndex"))

  def search(query: String) = {
    val queries = indices.map { _.search(query) rescue { case _=> Future.value(Nil) } }
    Future.collect(queries) map { results => (Set() ++ results.flatten) toList }
  }
}

class RemoteIndex(hosts: String) extends Index {
  val transport = ClientBuilder()
    .name("remoteIndex")
    .hosts(hosts)
    .codec(ThriftClientFramedCodec())
    .hostConnectionLimit(1)
    .timeout(500.milliseconds)
    .build()
  val client = new SearchbirdServiceClientAdapter(
      new thrift.SearchbirdService.ServiceToClient(
        transport, new TBinaryProtocol.Factory))

  def get(key: String) = client.get(key)
  def put(key: String, value: String) = client.put(key, value) map { _ => () }
  def search(query: String) = client.search(query) map { _.toList }
}
