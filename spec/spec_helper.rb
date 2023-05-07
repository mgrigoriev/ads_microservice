ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'sinatra'
require 'rspec'
require 'factory_bot'
require_relative '../app.rb'

Dir[File.join(__dir__, "support/**/*.rb")].each { |file| require file }

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include RequestHelpers, type: :request
end

# Define the app method for Rack::Test
def app
  App
end
