# set before using Bundler
ENV['RACK_ENV'] = 'test'

require 'bundler/setup'
Bundler.require(:default, :test)

ENV['HEROKU_OAUTH_ID'] = '12312312-1231-1231-1231-123123123123'
ENV['HEROKU_OAUTH_SECRET'] = '12312312-1231-1231-1231-123123123123'
ENV['SESSION_SECRET'] = '123123123123123123123123123123123123123123123123123123123123'

require './web/toolbelt'
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest-spec-context'
require 'rack/test'
require 'mocha/mini_test'
