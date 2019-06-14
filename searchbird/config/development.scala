import com.twitter.conversions.time._
import com.twitter.logging.config._
import com.twitter.ostrich.admin.config._
import com.twitter.searchbird.config._

// development mode.
new SearchbirdServiceConfig {

  shards = Seq(
    "localhost:9000",
    "localhost:9001",
    "localhost:9002"
  )

  // Where your service will be exposed.
  thriftPort = 9999

  // Expert-only: Ostrich stats and logger configuration.
  admin.statsNodes = new StatsConfig {
    reporters = new JsonStatsLoggerConfig {
      loggerName = "stats"
      serviceName = "searchbird"
    } :: new TimeSeriesCollectorConfig
  }

  loggers =
    new LoggerConfig {
      level = Level.DEBUG
      handlers = new FileHandlerConfig {
        filename = "searchbird.log"
        roll = Policy.SigHup
      }
    } :: new LoggerConfig {
      node = "stats"
      level = Level.INFO
      useParents = false
      handlers = new FileHandlerConfig {
        filename = "stats.log"
        formatter = BareFormatterConfig
      }
    }
}
