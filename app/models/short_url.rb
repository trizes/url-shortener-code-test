class ShortUrl
  def initialize(url)
    @url = url
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
