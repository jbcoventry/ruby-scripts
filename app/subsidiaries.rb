require "dotenv/load"
require "open-uri"
require "uri"
require "json"

if ARGV.empty?
  puts "Please include a company you would like to receive a list of subsidiaries for:"
  puts "ruby dob-get.rb 'Apple'"
  exit 1
end
query = "#{ARGV[0]}+subsidiaries"
response = URI.open("https://serpapi.com/search.json?engine=google&q=#{URI.encode_www_form_component query}&google_domain=google.com&gl=us&hl=en&api_key=#{ENV["API_KEY"]}").read
puts response
data = JSON.parse(response)
if data.dig("knowledge_graph", "subsidiaries").is_a?(Array)
  puts "#{query} has the following subsidiaries:"
  data["knowledge_graph"]["subsidiaries"].each { |subsidiary|
    puts subsidiary["name"]
  }
  exit
end

puts "We could not find any subsidiaries. Please try a different company."
