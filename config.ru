$stdout.sync = true

$:.unshift File.expand_path("../web", __FILE__)

require "honeybadger"
Honeybadger.configure do |config|
  config.api_key = ENV["HONEYBADGER_API_KEY"]
end

require "toolbelt_common_logger"
require "toolbelt"

use Honeybadger::Rack
use ToolbeltCommonLogger
run Toolbelt
