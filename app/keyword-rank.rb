require "dotenv/load"
require "open-uri"
require "uri"
require "csv"
require "json"

CSV.foreach("keywords-short.csv") { |keyword_params|
  query = URI.encode_www_form(q: keyword_params[0], location: keyword_params[1], async: "true",
    api_key: ENV["API_KEY"])
  response = JSON.parse(URI.open("https://httpbin.org/anything?#{query}").read)
  puts response["args"]
}
