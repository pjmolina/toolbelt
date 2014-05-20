$stdout.sync = true

require "bundler/setup"
Bundler.require

# Silence Rack Logger
class Rack::CommonLogger
  def call(env)
    @app.call(env)
  end
end

require "honeybadger"
Honeybadger.configure do |config|
  config.api_key = ENV["HONEYBADGER_API_KEY"]
end
use Honeybadger::Rack

$:.unshift File.expand_path("../web", __FILE__)
require "toolbelt"
run Toolbelt
