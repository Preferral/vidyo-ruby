require 'pry'
require 'vidyo'
require "savon/mock/spec_helper"
require_relative 'support/factory'

RSpec.configure do |config|
  config.include Savon::SpecHelper

  config.before(:all) { savon.mock! }
  config.after(:all)  { savon.unmock! }

end
