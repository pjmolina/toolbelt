$stdout.sync = true

require "bundler/setup"
Bundler.require

require "honeybadger"
Honeybadger.configure do |config|
  config.api_key = ENV["HONEYBADGER_API_KEY"]
end
use Honeybadger::Rack

$:.unshift File.expand_path("../web", __FILE__)
require "toolbelt_common_logger"
require "toolbelt"
use ToolbeltCommonLogger
run Toolbelt
