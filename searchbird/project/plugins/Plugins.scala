import sbt._

class Plugins(info: ProjectInfo) extends PluginDefinition(info) {
  import scala.collection.jcl
  val environment = jcl.Map(System.getenv())
  def isSBTOpenTwitter = environment.get("SBT_OPEN_TWITTER").isDefined
  def isSBTTwitter = environment.get("SBT_TWITTER").isDefined

  override def repositories = if (isSBTOpenTwitter) {
    Set("twitter.artifactory" at "http://artifactory.local.twitter.com/open-source/")
  } else if (isSBTTwitter) {
    Set("twitter.artifactory" at "http://artifactory.local.twitter.com/repo/")
  } else {
    super.repositories ++ Set(
      "twitter.com" at "http://maven.twttr.com/",
      "scala-tools" at "http://scala-tools.org/repo-releases/",
      "freemarker" at "http://freemarker.sourceforge.net/maven2/"
    )
  }
  override def ivyRepositories = Seq(Resolver.defaultLocal(None)) ++ repositories

  val standardProject = "com.twitter" % "standard-project" % "0.12.7"
  val sbtThrift = "com.twitter" % "sbt-thrift" % "1.4.4"
}
