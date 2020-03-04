require 'digest'

module UrlShortener
  SALT = 'salted and peppered'.freeze

  def self.encode(long_url)
    Digest::MD5.hexdigest(long_url + SALT).slice(0..8)
  end
end
