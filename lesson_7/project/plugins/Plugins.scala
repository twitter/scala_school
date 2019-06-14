import sbt._

class Plugins(info: ProjectInfo) extends PluginDefinition(info) {
  val twitterMaven = "twitter.com" at "https://maven.twttr.com/"
  val defaultProject = "com.twitter" % "standard-project" % "0.9.0"
}
