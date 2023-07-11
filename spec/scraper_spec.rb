require_relative "../scraper"

describe "#scrape_top_5_urls" do
  it "returns an array of the top 5 movies urls (strings)" do
    expected = [
      "https://www.imdb.com/title/tt0111161/",
      "https://www.imdb.com/title/tt0068646/",
      "https://www.imdb.com/title/tt0468569/",
      "https://www.imdb.com/title/tt0071562/",
      "https://www.imdb.com/title/tt0050083/"
    ]

    expect(scrape_top_5_urls).to eq(expected)
  end

  describe "#scrape_movie(url)" do
    it "return a hash with the movie info" do
      url = "https://www.imdb.com/title/tt0111161/"
      movie = {
        cast: ["Tim Robbins", "Morgan Freeman", "Bob Gunton"],
        director: "Frank Darabont",
        storyline: "The Shawshank Redemption has become a classic film - it's even IMDb's top-rated movie of all time - but did you know it almost had an entirely different cast behind those legendary bars?Andy and Red's ",
        title: "The Shawshank Redemption",
        year: 1994,
        rating: 9.39
      }
      expect(scrape_movie(url)).to eq(movie)
    end
  end
end