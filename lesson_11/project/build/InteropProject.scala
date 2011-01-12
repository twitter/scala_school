import sbt._
import com.twitter.sbt._

class InteropProject(info: ProjectInfo) extends DefaultProject(info) {
  override def compileOrder = CompileOrder.ScalaThenJava

  override def compileOptions = super.compileOptions ++ Seq(Unchecked) ++
    compileOptions("-encoding", "utf8") ++
    compileOptions("-Xcheckinit", "-Xwarninit")

  val junitInterface = "com.novocode" % "junit-interface" % "0.5" % "test->default"
}
