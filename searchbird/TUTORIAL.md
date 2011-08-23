# Welcome to Searchbird!

## Setup

Scala-bootstrapper has created a fully-functional Scala service for
you.  You can verify that things are set up correctly by doing:

    $ sbt update test

## Tutorial

### Run your service!

There are two ways to start your service.  You can build a runnable
jar and tell java to run it directly:

    $ sbt package-dist
    $ java -Dstage=development -jar ./dist/searchbird/searchbird-1.0.0-SNAPSHOT.jar

or you can ask sbt to run your service:

    $ sbt 'run -f config/development.scala'

### Verify that the service is running

The java/sbt command-lines will "hang" because the server is running in the
foreground. (In production, we use libslack-daemon to wrap java processes into
unix daemons.) Go to another terminal and check for a logfile. If your server
is named "searchbird", there should be a `searchbird.log` with contents like this:

    INF [20110615-14:05:41.656] stats: Starting JsonStatsLogger
    INF [20110615-14:05:41.674] admin: Starting TimeSeriesCollector
    DEB [20110615-14:05:41.792] nio: Using the autodetected NIO constraint level: 0

That's your indication that the server is running. :)

### View the Thrift IDL for your service

The IDL for your service is in `src/main/thrift/searchbird.thrift`.  The
Thrift compiler uses the IDL to generate bindings for various
languages, making it easy for scripts in those languages to talk to
your service.  More information about Thrift and how to write an IDL
for your service can be found [here](http://wiki.apache.org/thrift/Tutorial).

### Call your service from ruby

Your service implements simple get() and put() methods.  Once you have
your server running, as above, bring up a different shell and:

    $ cd searchbird
    $ bundle install
    $ ./dist/searchbird/scripts/console
    >> $client
    >> $client.put("key1", "valueForKey")
    >> $client.get("key1")

### Look at the stats for your service

By default, your project is configured to use
[Ostrich](https://github.com/twitter/ostrich), a library for service
configuration, administration, and stats reporting. Your config file
in `config/development.scala` defines which port ostrich uses for admin
requests. You can view the stats via that port:

    $ curl localhost:9900/stats.txt
    counters:
      Searchbird/connects: 1
      Searchbird/requests: 2
      Searchbird/success: 2
    ...

Ostrich also stores historial stats data and can build
[graphs](http://localhost:9900/graph/) for you.

### Stop the service

You can ask the server to shutdown over the admin port also:

    $ curl localhost:9900/shutdown.txt
    ok

### View the implementation of get() and put()

In `src/main/scala`, take a look at `SearchbirdServiceImpl.scala`. (This may
have a different name, based on what you called your server.)

The base interface is specified by thrift. Additionally, we're using Twitter's
async I/O framework: finagle. Finagle (and a lot of great documentation about
it) is hosted here: https://github.com/twitter/finagle

### Try adding some timers and counters

At the top of SearchbirdServiceImpl.scala, add:

    import com.twitter.ostrich.stats.Stats

Then inside get():

    Stats.incr("searchbird.gets")

and inside put():

    Stats.incr("searchbird.puts")

Then restart your server, talk to the server via console, and check
your stats:

    $ curl localhost:9900/stats.txt
    counters:
      Searchbird/connects: 1
      Searchbird/requests: 2
      Searchbird/success: 2
      searchbird.gets: 1
      searchbird.puts: 1

You can also time various things that your server is doing, for
example:

    Stats.time("searchbird.put.latency") {
      Thread.sleep(10) // so you can see it
      database(key) = value
    }

### Specs: let's add some tests

[Specs](http://code.google.com/p/specs/) is a Behavior-Driven Design
framework that allows you to write semi-human-readable descriptions of
how your service should behave and test that those descriptions are
valid.  You already have some Specs code for your project in
src/test/scala/com/twitter/searchbird/SearchbirdServiceSpec.scala.  Check
out the existing test and add a new one for the counter functionality
we just added.

    import com.twitter.ostrich.stats.Stats

    ...

    "verify stats" in {
      val counters = Stats.getCounters
      foofa.put("name", "bluebird")()
      foofa.get("name")() mustEqual "bluebird"
      counters.getOrElse("foofa.gets", 1) must_==1
      counters.getOrElse("foofa.puts", 1) must_==1
    }

TODO: add link to scala school lesson on Specs

### Automatically compile and test your server when you change code

By now you've had to Ctrl-C your server and restart it to get changes
to show up.  This gets a little tiresome.  The build tool we are
using,
[SBT (simple build tool)](http://code.google.com/p/simple-build-tool/)
has a console that you can access by just running "sbt" from the
command line.

    $ sbt
    [info] Standard project rules 0.11.4 loaded (2011-03-18).
    [warn] No .svnrepo file; no svn repo will be configured.
    [info] Building project searchbird 1.0.0-SNAPSHOT against Scala 2.8.1
    [info]    using SearchbirdProject with sbt 0.7.4 and Scala 2.7.7

SBT has a wide array of features, but a useful one right now is to
use the "~ test" command.

    > ~ test

The tilde tells SBT to look for changes to your source files and
re-execute the command when it detects a change.

TODO: add link to scala school lesson on SBT

### Add an admin / dashboard page.

### Add a new dependency to your project, perhaps twitter/util?

### Take a tour of the logs our service is producing.

### Add command-line parameters for your service.
-D foo=bar
runtime.arguments.get("foo")

### Storage: let's persist the data in Cassandra!

### Twitter API: let's listen to the Firehose!

### Twitter API: let's fetch some statuses & users & stuff.
