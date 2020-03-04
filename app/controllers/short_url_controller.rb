require './app/repositories/short_url_repository'

class ShortUrlController < Sinatra::Base
  post '/' do
    url = repo.create_item

    json url
  end

  get '/list' do
    json data: repo.list
  end

  get '/*' do
    query = params[:splat].first[0..8]

    short_url = repo.find(query)

    redirect short_url.url, 301
  end

  def repo
    ShortUrlRepository.new(permitted_params)
  end

  def permitted_params
    params.slice(:url)
  end
end
