require "dotenv/load"
require "uri"
require "open-uri"
require "json"
require "async"
require "csv"

search_variables = CSV.read("keywords-short.csv")
search_ids = Async { |query_variables|
  tasks = search_variables.map { |term, location|
    query_variables.async {
      query = URI.encode_www_form(
        q: term,
        location: location,
        async: "true",
        num: "100",
        api_key: ENV["API_KEY"]
      )
      response = URI.open("https://serpapi.com/search.json?#{query}")
      JSON.parse(response.read)["search_metadata"]["id"]
    }
  }
  tasks.map(&:wait)
}.wait

rankings = Async { |query_variables|
  tasks = search_ids.map { |search_id|
    query_variables.async {
      loop {
        response = URI.open("https://serpapi.com/searches/#{search_id}.json?api_key=#{ENV["API_KEY"]}")
        data = JSON.parse(response.read)
        if data["search_metadata"]["status"] == "Success"

          rank = data["organic_results"].find_index { |result|
            URI.parse(result["link"]).host == "serpapi.com"
          }
          rank = rank ? rank + 1 : rank
          break({query: data["search_parameters"]["q"],
                 location: data["search_parameters"]["location_used"],
                 rank: rank || "Not in top 100"})
        end
        puts "ID:#{search_id} status:#{data["search_metadata"]["status"]}"
        sleep 3
      }
    }
  }
  tasks.map(&:wait)
}.wait
puts rankings
