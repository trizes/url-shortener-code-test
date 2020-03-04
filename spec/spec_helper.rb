require 'rack/test'
require 'rspec'
require './app'
require 'ffaker'
require 'pry'

ENV['RACK_ENV'] = 'test'

RSpec.configure do |c|
  c.include Rack::Test::Methods

  c.filter_run :focus
  c.run_all_when_everything_filtered = true

  c.order = :random
  Kernel.srand c.seed

  c.before(:each) do
    ShortUrl.destroy_all
  end
end

def json_response
  data ||= JSON.parse(last_response.body, symbolize_names: true)
end
