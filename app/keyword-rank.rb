require "dotenv/load"
require "open-uri"
require "uri"
require "csv"

CSV.foreach("keywords-short.csv") { |keyword_params|
  query = keyword_params[0]
  location = keyword_params[1]
  response = URI.open("https://serpapi.com/search.json?engine=google&q=#{URI.encode_www_form_component query}&location=#{URI.encode_www_form_component location}&async=true&num=100&api_key=#{ENV["API_KEY"]}").read

  puts response
}
