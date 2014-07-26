require 'action_view'
require 'nokogiri'

RSpec.configure do |config|
  config.color = true
  config.formatter = 'documentation'
end

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
