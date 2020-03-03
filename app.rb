require 'sinatra/base'
require 'sinatra/json'

Dir.glob(
  './app/{models,controllers}/*.rb'
).each { |file| require file }
