package com.twitter.searchbird

class SearchbirdServiceSpec extends AbstractSpec {
  "SearchbirdService" should {

    // TODO: Please implement your own tests.

    "set a key, get a key" in {
      searchbird.put("name", "bluebird")()
      searchbird.get("name")() mustEqual "bluebird"
      searchbird.get("what?")() must throwA[Exception]
    }
  }
}
