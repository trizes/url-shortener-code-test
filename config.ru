require './app.rb'

map('/') { run ShortUrlController }
