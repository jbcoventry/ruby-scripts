require "open-uri"
require "nokogiri"

query = ARGV[0]

response = URI.open("https://www.google.com/search?q=#{URI.encode_www_form_component query}&ie=utf-8",
  # To get cookie, open a chrome incognito tab, open dev tools, do a google search, then in the network tab copy the cookie from the "request headers" on one of the network requests that has them.
  "Cookie" => "",
  "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36").read

doc = Nokogiri::HTML(response)

puts "#{query}'s Date of Birth"

puts doc.at_xpath(
  "//g-inner-card//div[
     text()
     and
     not( contains(., 'Age') )
   ]"
).text
