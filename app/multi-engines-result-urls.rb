require "dotenv/load"
require "open-uri"
require "uri"
require "json"

engines = ["google", "bing", "baidu", "yahoo"]

engines.each { |engine|
  response = URI.open("https://serpapi.com/search.json?engine=#{URI.encode_www_form_component engine}&#{(engine == "yahoo") ? "p" : "q"}=serpapi&api_key=#{ENV["API_KEY"]}").read
  data = JSON.parse(response)
  puts engine
  puts data["search_metadata"]["json_endpoint"]
  puts data["search_metadata"]["raw_html_file"]
}
