require 'spec_helper'

RSpec.describe ShortUrlRepository do
  let(:url_list) { ['1', '2', '3'] }
  let(:short_url_model) { double(save: true) }
  let(:params) { { url: FFaker::Internet.http_url } }
  let(:subject) { ShortUrlRepository.new(params) }

  before do
    allow(ShortUrl).to receive(:new).and_return(short_url_model)
  end

  describe '#list' do
    before do
      allow(ShortUrl).to receive(:all).and_return(url_list)
    end

    it 'lists known urls' do
      expect(subject.list).to eq url_list
    end
  end

  describe '#create_item' do
    it 'creates a short url' do
      expect(subject.create_item).to eq(short_url_model)
    end

    it 'saves the url in db' do
      subject.create_item

      expect(short_url_model).to have_received(:save)
    end
  end
end
