require "dotenv/load"
require "open-uri"
require "uri"
require "json"

locations = [
  "Austin,Texas,United States",
  "New York,New York,United States",
  "Los Angeles,California,United States",
  "Chicago,Illinois,United States",
  "Houston,Texas,United States",
  "Phoenix,Arizona,United States",
  "Philadelphia,Pennsylvania,United States",
  "San Antonio,Texas,United States",
  "San Diego,California,United States",
  "Dallas,Texas,United States"
]
locations.each { |location|
  response = URI.open("https://serpapi.com/search.json?engine=google&q=serpapi&location=#{URI.encode_www_form_component location}&google_domain=google.com&gl=us&hl=en&api_key=#{ENV["API_KEY"]}").read
  data = JSON.parse(response)
  puts location
  puts data["organic_results"]
}
