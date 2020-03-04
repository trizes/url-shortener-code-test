require 'spec_helper'

RSpec.describe ShortUrlController do
  def app
    ShortUrlController
  end

  let(:subject) { json_response }
  let(:url) { FFaker::Internet.http_url }
  let(:shortened) { ShortUrl.new(url) }

  describe 'POST url' do
    it 'returns short URL' do
      post '/', url: url

      expect(subject[:short_url]).to be_kind_of(String)
    end

    it 'returns the original URL' do
      post '/', url: url

      expect(subject[:url]).to eql(url)
    end
  end

  describe 'GET list' do
    before(:each) do
      ShortUrl.new(url).save
      ShortUrl.new(url).save
    end

    it 'returns list of shortened urls' do
      get '/list'

      urls = subject[:data]

      expect(urls.length).to be 2
      expect(urls.first[:url]).to eql url
    end
  end

  describe 'GET short_url' do
    it 'finds saved url' do
      shortened.save
      get "/#{shortened.short_url}"
      expect(last_response.status).to be 301
    end

    it "returns 404 if short url is not known" do
      '...'
    end
  end
end
