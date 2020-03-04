class ShortUrl
  @storage = []

  def self.all
    @storage
  end

  def self.storage
    @storage
  end

  def self.save(obj)
    @storage.push(obj)
  end

  def self.destroy_all
    @storage = []
  end

  def initialize(url)
    @url = url
    @short_url = UrlShortener.encode(url)
    @created_at = Time.now.utc
    @updated_at = @created_at.dup
  end

  attr_reader :url, :short_url, :created_at, :updated_at

  def save
    self.class.save(self)
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
