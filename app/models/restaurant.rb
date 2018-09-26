YELP_API_KEY = Rails.application.credentials.yelp[:api_key]

class Restaurant < ApplicationRecord
  has_many :reviews
  belongs_to :third_party_rating

  def set_yelp_rating
    rating = ThirdPartyRating.new
    rating.yelp = fetch_yelp_rating
    rating.save
    self.third_party_rating = rating
    self.save
  end

  private

  def fetch_yelp_rating
    term = self.name.parameterize
    lat = self.google_lat
    lng = self.google_lng
    limit = 1
    categories = "restaurants, All"
    url = "https://api.yelp.com/v3/businesses/search?term=#{term}&latitude=#{lat}&longitude=#{lng}&limit=#{limit}&categories=#{categories}"
    headers = { :Authorization => "Bearer #{YELP_API_KEY}" }

    response = JSON.parse(RestClient.get url, headers)

    response["businesses"].first["rating"]
  end
end
