namespace java com.twitter.searchbird.thrift
namespace rb Searchbird

/**
 * It's considered good form to declare an exception type for your service.
 * Thrift will serialize and transmit them transparently.
 */
exception SearchbirdException {
  1: string description
}

/**
 * A simple memcache-like service, which stores strings by key/value.
 * You should replace this with your actual service.
 */
service SearchbirdService {
  string get(1: string key) throws(1: SearchbirdException ex)

  void put(1: string key, 2: string value)
  list<string> search(1: string query)
}
