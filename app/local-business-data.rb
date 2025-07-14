require "dotenv/load"
require "open-uri"
require "uri"
require "json"

if ARGV.empty?
  puts "Please include latitude, longitude, and a local business you would like information about:"
  puts "ruby app/local-business-data.rb @40.7455096,-74.0083012,14z 'Ground Central Coffee Company'"
  exit 1
end
location = ARGV[0]
query = ARGV[1]
response = URI.open("https://serpapi.com/search.json?engine=google_maps&q=#{URI.encode_www_form_component query}&ll=#{URI.encode_www_form_component location}&type=search&api_key=#{ENV["API_KEY"]}").read
data = JSON.parse(response)
if data["local_results"].is_a?(Array)
  puts "#{query} information:"
  puts "open hours:"
  data["local_results"].first["operating_hours"].each { |key, value|
    puts "#{key}: #{value}"
  }
  puts "Rating:"
  puts data["local_results"].first["rating"]
  puts "Review Count:"
  puts data["local_results"].first["reviews"]

  exit
end

puts "We could not find any subsidiaries. Please try a different company."
