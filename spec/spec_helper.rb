require 'coveralls'

Coveralls.wear!

require 'action_view'
require 'nokogiri'
require 'rails'

RSpec.configure do |config|
  config.color = true
  config.formatter = 'documentation'
end

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

class DummyApp < Rails::Application
end

Rails.application = DummyApp.new
