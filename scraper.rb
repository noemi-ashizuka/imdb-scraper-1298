require "open-uri"
require "nokogiri"

# scrape_top_5_urls => an array with 5 urls(string)
def scrape_top_5_urls
  url = "https://www.imdb.com/chart/top"
  html_doc = URI.open(url, 'Accept-Language' => 'en', "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0").read
  html = Nokogiri::HTML(html_doc)

  html.search(".lister-list td.titleColumn a").first(5).map do |element|
    "https://www.imdb.com#{element.attribute("href").value.split(/\?/).first}"
  end
end

# scrape_top_5_urls

# scrape_movie(url) => a hash with the movie info

def scrape_movie(url)
  html_content = URI.open(url, 'Accept-Language' => 'en', "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0").read
  doc = Nokogiri::HTML(html_content)

  director = doc.search('.ipc-metadata-list-item__list-content-item.ipc-metadata-list-item__list-content-item--link').text.strip.split('Stephen').first
  year = doc.search(' .sc-52d569c6-0 .ipc-inline-list .ipc-link').text.strip[0...4].to_i
  synopsis = doc.search(".ipc-html-content-inner-div").text.strip[0..200]
  cast = doc.search('.sc-bfec09a1-1.fUguci').first(3).map do |element|
    element.text.strip
  end
  title = doc.search(".sc-afe43def-1.fDTGTb").text.strip
  rating = doc.search("span.sc-bde20123-1.iZlgcd").text.strip.to_f

  {
    cast: cast,
    director: director,
    storyline: synopsis,
    title: title,
    year: year,
    rating: rating
  }


end

p scrape_movie("https://www.imdb.com/title/tt0111161/")
