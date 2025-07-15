require "open-uri"

response = URI.open("https://www.google.com/search?q=dogs").read

puts response
