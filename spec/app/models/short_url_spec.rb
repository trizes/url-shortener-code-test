require 'spec_helper'

RSpec.describe ShortUrl do
  let(:long_url) { FFaker::Internet.http_url }
  let(:subject) { described_class.new(long_url) }

  it 'shortens the urls on init' do
    expect(subject.short_url).to eql UrlShortener.encode(long_url)
  end

  it 'is not valid for malformed urls' do
    expect(described_class.new('invalid')).not_to be_valid
  end

  it 'appends http to the urls' do
    link = 'noschema.com/website'

    model = described_class.new(link)

    expect(model.url).to eq "http://#{link}"
  end

  context 'duplicates' do
    it 'does not save duplicate' do
      subject.save

      expect(ShortUrl).not_to receive(:save)

      described_class.new(subject.url).save
    end
  end
end
