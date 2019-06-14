import sbt._
import Process._
import com.twitter.sbt._

/**
 * Sbt project files are written in a DSL in scala.
 *
 * The % operator is just turning strings into maven dependency declarations, so lines like
 *     val example = "com.example" % "exampleland" % "1.0.3"
 * mean to add a dependency on exampleland version 1.0.3 from provider "com.example".
 */
class SearchbirdProject(info: ProjectInfo) extends StandardServiceProject(info)
  with CompileThriftScala
  with NoisyDependencies
  with DefaultRepos
  with SubversionPublisher
  with PublishSourcesAndJavadocs
  with PublishSite
{
  val finagleVersion = "1.8.4"

  val finagleC = "com.twitter" % "finagle-core" % finagleVersion
  val finagleT = "com.twitter" % "finagle-thrift" % finagleVersion
  val finagleO = "com.twitter" % "finagle-ostrich4" % finagleVersion

  // thrift
  val libthrift = "thrift" % "libthrift" % "0.5.0"
  val util = "com.twitter" % "util" % "1.11.2"

  override def originalThriftNamespaces = Map("Searchbird" -> "com.twitter.searchbird.thrift")
  override val scalaThriftTargetNamespace = "com.twitter.searchbird"

  val slf4jVersion = "1.5.11"
  val slf4jApi = "org.slf4j" % "slf4j-api" % slf4jVersion withSources() intransitive()
  val slf4jBindings = "org.slf4j" % "slf4j-jdk14" % slf4jVersion withSources() intransitive()

  // for tests
  val specs = "org.scala-tools.testing" % "specs_2.8.1" % "1.6.7" % "test" withSources()
  val jmock = "org.jmock" % "jmock" % "2.4.0" % "test"
  val hamcrest_all = "org.hamcrest" % "hamcrest-all" % "1.1" % "test"
  val cglib = "cglib" % "cglib" % "2.1_3" % "test"
  val asm = "asm" % "asm" % "1.5.3" % "test"
  val objenesis = "org.objenesis" % "objenesis" % "1.1" % "test"

  override def mainClass = Some("com.twitter.searchbird.Main")

  override def subversionRepository = Some("https://svn.local.twitter.com/maven-public")
}
