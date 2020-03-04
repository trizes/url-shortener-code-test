require 'sinatra/base'
require 'sinatra/json'

Dir.glob(
  './app/{models,services,controllers}/*.rb'
).each { |file| require file }
