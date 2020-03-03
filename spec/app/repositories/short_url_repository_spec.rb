require 'spec_helper'

RSpec.describe ShortUrlRepository do
  let(:short_url_model) { double() }
  let(:params) { { url: FFaker::Internet.http_url } }
  let(:subject) { ShortUrlRepository.new(params) }

  before do
    allow(ShortUrl).to receive(:new).and_return(short_url_model)
  end

  describe '#create_item' do
    it 'creates a short url' do
      expect(subject.create_item).to eq(short_url_model)
    end
  end
end
