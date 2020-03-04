require './app.rb'

map('/') { run ShortUrlController }

run ShortUrlController.new
