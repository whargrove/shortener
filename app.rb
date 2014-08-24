require "sinatra"
require "./service/validator"
require "./service/shortener"

post "/url/new" do
  url = params[:url]
  if !!Validator.validate(url)
    shortener = Shortener.new
    return shortener.shorten(url)
  end
end

get "/:code" do
  code = params[:code]
  shortener = Shortener.new
  redirect to(shortener.retrieve(code)), 303
end
