require 'spec_helper'

RSpec.describe ShortUrlController do
  def app
    ShortUrlController
  end

  let(:subject) { json_response }
  let(:url) { FFaker::Internet.http_url }

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
end
