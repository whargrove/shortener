configure do
  require "redis"
  if ENV["REDISTOGO_URL"]
    uri = URI.parse(ENV["REDISTOGO_URL"])
    $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  else
    $redis = Redis.new
  end
end

class Shortener

  def shorten(url)
    digest = OpenSSL::Digest::SHA1.new
    short_code = digest.update(url).to_s.slice(0..4)
    $redis.set(short_code, url, {:nx => ""})
    return short_code
  end

  def retrieve(short_code)
    $redis.get(short_code)
  end

end
