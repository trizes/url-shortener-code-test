class ShortUrlRepository
  def initialize(params)
    @params = params
  end

  def create_item
    {
      short_url: '/abc123',
      url: @params[:url]
    }
  end
end
