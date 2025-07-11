require "dotenv/load"
require "open-uri"
require "json"

if ARGV.empty?
  puts "Please include a famous persons name as an argument as below:"
  puts "ruby dob-get.rb 'Tom Hanks'"
  exit 1
end
query = ARGV[0]
response = URI.open("https://serpapi.com/search.json?engine=google_light&q=#{query}&google_domain=google.com&gl=us&hl=en&api_key=#{ENV["API_KEY"]}").read
data = JSON.parse(response)
puts data
if data.dig("knowledge_graph", "born").is_a?(String)
  puts "#{Query} was born on:"
  puts data["knowledge_graph"]["born"]
  exit
end

puts "We could not find a date of birth. Please try again with a more famous person."
