require 'spec_helper'

RSpec.describe ShortUrlController do
  def app
    ShortUrlController
  end

  describe 'POST url' do
    let(:url) { FFaker::Internet.http_url }
    let(:subject) { json_response }

    it 'returns short URL' do
      post '/', url: url

      expect(subject[:short_url]).to be_kind_of(String)
    end

    it 'returns the original URL' do
      post '/', url: url

      expect(subject[:url]).to eql(url)
    end
  end
end
