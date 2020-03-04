require 'uri'

class ShortUrl
  # Data storage, mimics array like return values
  # Is sorted to mimic DB indexes and nlogn lookups

  @storage = SortedSet[]

  # TODO: class methods below are ORM related
  # should moved out into a module or may be
  # already implemented by the DB

  def self.all
    @storage.to_a
  end

  def self.save(obj)
    @storage.add(obj)
  end

  def self.destroy_all
    @storage.clear
  end

  def self.find(id)
    @storage.find { |el| el.short_url == id }
  end

  def initialize(url)
    @url = url
    @errors = []
    url_shorten
    add_timestamps
  end

  attr_reader :url, :short_url, :created_at, :updated_at, :errors

  URI_REGEX = %r{^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$}ix.freeze

  def add_timestamps
    @created_at = Time.now.utc
    @updated_at = @created_at.dup
  end

  def url_shorten
    uri = URI.parse(url)

    uri = URI.parse("http://#{url}") unless uri.scheme

    if uri.hostname =~ URI_REGEX
      @url = uri.to_s
      @short_url = UrlShortener.encode(url)
    else
      @errors << 'Unprocessable url'
    end
  end

  def save
    self.class.save(self) if valid?

    self
  end

  def valid?
    @errors.empty?
  end

  # required for sorted set
  def <=>(other)
    short_url <=> other.short_url
  end

  def as_json(_ = {})
    {
      short_url: @short_url, url: @url
    }
  end

  def to_json(*args)
    as_json.to_json(*args)
  end
end
