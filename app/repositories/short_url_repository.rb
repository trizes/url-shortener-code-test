class ShortUrlRepository
  def initialize(params)
    @params = params
  end

  def list
    ShortUrl.all
  end

  def create_item
    url = ShortUrl.new(@params[:url])

    url.save

    url
  end

  def find(query)
    ShortUrl.find query[0..8]
  end
end
