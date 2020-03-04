source 'https://rubygems.org'

gem 'sinatra'
gem 'sinatra-contrib'
gem 'rbtree'

group :development, :test do
  gem 'guard-rspec'

  # squelch ruby 2.7.0 pry warnings, fixed in github
end
  gem 'pry',
      git: 'https://github.com/pry/pry.git',
      ref: '272b3290b5250d28ee82a5ff65aa3b29b825e37b'

group :test do
  gem 'ffaker'
  gem 'rack-test'
  gem 'rspec'
end
