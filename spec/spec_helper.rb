$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'simple_shipping'
require 'ruby-debug'


# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
require File.expand_path("../support/custom_matchers/basic_matcher", __FILE__)
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include SimpleShipping::CustomMatchers
end
