require './app/repositories/short_url_repository'

class ShortUrlController < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, -> { File.join(root, 'views') }

  get '/' do
    erb :index
  end

  post '/' do
    url = repo.create_item

    if url.valid?
      json url
    else
      halt 422, { 'Content-Type' => 'application/json' }, { errors: url.errors }.to_json
    end
  end

  get '/list' do
    json data: repo.list
  end

  get '/*' do
    short_url = repo.find(params[:splat].first)

    if short_url
      redirect short_url.url, 301
    else
      status 404
    end
  end

  def repo
    ShortUrlRepository.new(permitted_params)
  end

  def permitted_params
    request_params.slice(:url)
  end

  def request_params
    if request.post?
      request.body.rewind
      JSON.parse(request.body.read, symbolize_names: true)
    else
      params
    end
  end
end
