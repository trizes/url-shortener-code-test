require './app/repositories/short_url_repository'

class ShortUrlController < Sinatra::Base
  post '/' do
    url = repo.create_item

    json url
  end

  def repo
    ShortUrlRepository.new(permitted_params)
  end

  def permitted_params
    params.slice(:url)
  end
end