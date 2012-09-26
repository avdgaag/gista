require 'bundler'
Bundler.require :development

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'gista'
require File.expand_path('../support/api_request_examples', __FILE__)

RSpec.configure do |config|
  config.before do
    FakeWeb.allow_net_connect = false
  end
end
