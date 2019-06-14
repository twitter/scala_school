package com.twitter.searchbird

import com.twitter.util._
import config._

class SearchbirdServiceImpl(config: SearchbirdServiceConfig, index: Index) extends SearchbirdServiceServer {
  val serverName = "Searchbird"
  val thriftPort = config.thriftPort

  def get(key: String) = index.get(key)
  def put(key: String, value: String) =
    index.put(key, value) map { _ => null: java.lang.Void }
  def search(query: String) = index.search(query)
}
