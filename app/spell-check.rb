require "dotenv/load"
require "open-uri"
require "uri"
require "json"

if ARGV.empty?
  puts "Please include a misspelled word as below:"
  puts "ruby app/spell-check 'bananna'"
  exit 1
end
query = ARGV[0]
response = URI.open("https://serpapi.com/search.json?engine=google&q=#{URI.encode_www_form_component query}&google_domain=google.com&gl=us&hl=en&api_key=#{ENV["API_KEY"]}").read
data = JSON.parse(response)
if data.dig("search_information", "spelling_fix").is_a?(String)
  puts "#{query} is actually spelled:"
  puts data["search_information"]["spelling_fix"]
  exit
end

puts "Please spell your world more or less incorrectly."
