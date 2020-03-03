require 'sinatra/base'
require 'sinatra/json'

Dir.glob(
  './app/{controllers}/*.rb'
).each { |file| require file }
