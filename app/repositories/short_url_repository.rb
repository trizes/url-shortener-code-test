class ShortUrlRepository
  def initialize(params)
    @params = params
  end

  def create_item
    ShortUrl.new(@params[:url])
  end
end
