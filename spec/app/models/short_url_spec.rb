require 'spec_helper'

RSpec.describe ShortUrl do
  let(:long_url) { FFaker::Internet.http_url }
  let(:subject) { described_class.new(long_url) }

  context 'url shortening' do
    it 'shortens the urls on init' do
      expect(subject.short_url).to eql UrlShortener.encode(long_url)
    end
  end
end
