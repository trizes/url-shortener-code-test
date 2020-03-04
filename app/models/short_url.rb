class ShortUrl
  @storage = []

  def self.all
    @storage
  end

  def self.storage
    @storage
  end

  def initialize(url)
    @url = url
  end

  def save
    self.class.storage << self
  end

  def as_json(_ = {})
    {
      short_url: '/abc123', url: @url
    }
  end

  def to_json(*args)
    as_json.to_json(*args)
  end
end
