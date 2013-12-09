$stdout.sync = true

require "bundler/setup"
Bundler.require

require "honeybadger"
Honeybadger.configure do |config|
  config.api_key = ENV["HONEYBADGER_API_KEY"]
end
use Honeybadger::Rack

use Rack::Session::Cookie, secret: 'guess-me'
use ::Heroku::Bouncer, oauth: { id: ENV['HEROKU_OAUTH_ID'], secret: ENV['HEROKU_OAUTH_SECRET'] },
                       secret: ENV['SESSION_SECRET'],
                       session_sync_nonce: 'heroku_session_nonce',
                       expose_user: true,
                       allow_anonymous: lambda { |_| true }

$:.unshift File.expand_path("../web", __FILE__)
require "toolbelt_common_logger"
require "toolbelt"
use ToolbeltCommonLogger
run Toolbelt
