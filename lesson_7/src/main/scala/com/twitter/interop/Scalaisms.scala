package com.twitter.interop

import java.io.IOException
import scala.throws
import scala.reflect.{BeanProperty, BooleanBeanProperty}

class SimpleClass(name: String, val acc: String, @BeanProperty var mutable: String) {
  val foo = "foo"
  var bar = "bar"
  @BeanProperty
  val fooBean = "foobean"
  @BeanProperty
  var barBean = "barbean"
  @BooleanBeanProperty
  var awesome = true

  def dangerFoo() = {
    throw new IOException("SURPRISE!" + name)
  }

  @throws(classOf[IOException])
  def dangerBar() = {
    throw new IOException("NO SURPRISE!" + name)
  }
}

trait MyTrait {
  def traitName:String
  def upperTraitName = traitName.toUpperCase
}

class TraitImpl(name: String) extends MyTrait {
  def traitName = name
}

object TraitImpl {
  def apply = new TraitImpl("foo")
  def apply(name: String) = new TraitImpl(name)
}

class ClosureClass[+V] {
  def printResult[T](f: => T) = {
    println(f)
  }

  def printResult[T <: Number](f: String => T) = {
    println(f("HI THERE"))
  }
}

class VarianceClass[-T >: CharSequence, +V](v: V) {
  def get = v
  def printT(t: T) = {
    println(t)
  }
}
