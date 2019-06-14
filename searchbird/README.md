# Project Searchbird

*Deprecated content*: this lesson depended on a Ruby library that is
no longer in use at Twitter and has been unpublished. Because of the
missing dependency this lesson no longer works.

Welcome to your searchbird project!  To make sure things are working
properly, you may want to:

    $ sbt update test

There is a tutorial for what to do next, which you can find in the
scala-bootstrapper README.rdoc file.

# Configuring Intellij

If you want to setup Intellij, it has to happen off to the side:

    $ sbt
    > *sbtIdeaRepo at https://mpeltonen.github.com/maven/
    > *idea is com.github.mpeltonen sbt-idea-processor 0.4.0
    > update
    > idea
