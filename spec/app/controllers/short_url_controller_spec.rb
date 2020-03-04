require 'spec_helper'

RSpec.describe ShortUrlController do
  def app
    ShortUrlController
  end

  let(:subject) { json_response }
  let(:url) { FFaker::Internet.http_url }
  let(:short_url_model) { ShortUrl.new(url).save }

  describe 'POST url' do
    it 'returns short URL' do
      post '/', { url: url }.to_json

      expect(subject[:short_url]).to be_kind_of(String)
    end

    it 'returns the original URL' do
      post '/', { url: url }.to_json

      expect(subject[:url]).to eql(url)
    end

    it 'returns validation errors' do
      post '/', { url: 'invalid' }.to_json

      expect(last_response.status).to be 422
    end
  end

  describe 'GET list' do
    before(:each) do
      short_url_model
    end

    it 'returns list of shortened urls' do
      get '/list'

      urls = subject[:data]

      expect(urls.length).to be 1
      expect(urls.first[:url]).to eql url
    end
  end

  describe 'GET short_url' do
    it 'finds saved url' do
      get "/#{short_url_model.short_url}"

      expect(last_response.status).to be 301
    end

    it 'redirects to full url' do
      get "/#{short_url_model.short_url}"

      expect(last_response.location).to eql short_url_model.url
    end

    it 'returns 404 if short url is not known' do
      get '/does_not_exist'

      expect(last_response.status).to be 404
    end
  end
end
