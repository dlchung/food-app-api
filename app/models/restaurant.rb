YELP_API_KEY = Rails.application.credentials.yelp[:api_key]
FOURSQUARE_CLIENT_ID = Rails.application.credentials.foursquare[:client_id]
FOURSQUARE_CLIENT_SECRET = Rails.application.credentials.foursquare[:client_secret]

class Restaurant < ApplicationRecord
  has_many :reviews
  belongs_to :third_party_rating, required: false

  # def set_yelp_rating
  #   rating = ""
  #
  #   if self.third_party_rating
  #     rating = self.third_party_rating
  #     puts "RATING EXISTS"
  #   else
  #     rating = ThirdPartyRating.new
  #     rating.yelp = fetch_yelp_rating
  #     rating.save
  #     self.third_party_rating = rating
  #     self.save
  #     puts "NEW RATING"
  #   end
  #
  #   rating
  # end

  def set_third_party_rating(platform)
    rating = ""

    if self.third_party_rating
      puts "RATING OBJ EXISTS"
      rating = self.third_party_rating
      if rating[platform]
        puts "#{platform} RATING EXISTS"
      else
        rating[platform] = fetch_rating(platform)
        rating.save
        puts "NEW RATING TYPE #{platform}"
      end
    else
      rating = ThirdPartyRating.new
      rating[platform] = fetch_rating(platform)
      rating.save

      self.third_party_rating = rating
      self.save
      puts "NEW RATING OBJECT"
    end

    rating
  end

  private

  def fetch_rating(platform)
    case platform
      when "yelp"
        fetch_yelp_rating
      when "foursquare"
        fetch_foursquare_rating
      else
    end
  end

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

  def fetch_foursquare_rating
    v = "20180928"
    ll = "#{self.google_lat},#{self.google_lng}"
    intent = "match"
    limit = 1
    name = self.name.parameterize

    url = "https://api.foursquare.com/v2/venues/search?client_id=#{FOURSQUARE_CLIENT_ID}&client_secret=#{FOURSQUARE_CLIENT_SECRET}&v=#{v}&ll=#{ll}&intent=#{intent}&limit=#{limit}&name=#{name}"
    response = JSON.parse(RestClient.get url)
    foursquare_id = response["response"]["venues"].first["id"]
    puts foursquare_id

    details_url = "https://api.foursquare.com/v2/venues/#{foursquare_id}?client_id=#{FOURSQUARE_CLIENT_ID}&client_secret=#{FOURSQUARE_CLIENT_SECRET}&v=#{v}"
    details_response = JSON.parse(RestClient.get details_url)
    puts details_response["response"]["venue"]["rating"]
    details_response["response"]["venue"]["rating"]
  end
end
