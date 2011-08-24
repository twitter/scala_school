# Docs at http://confluence.local.twitter.com/display/RELEASE/Twitter-cap-utils+README
begin
  require 'rubygems'
  require "bundler/setup"
  require "railsless-deploy"
  require 'twitter_cap_utils'
rescue LoadError => e
  puts e.message
  abort "Please gem install twitter-cap-utils railsless-deploy"
end

set :user, :twitter
set :application, "searchbird"
set :repository, "http://git.local.twitter.com/ro/#{application}"

task :staging do
  role :app, "server1", "server2", "etc"
end

task :canary do
  role :app, "server1"
end

task :production do
  role :app, "server1", "server2", "etc"
end

