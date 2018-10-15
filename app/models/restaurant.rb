YELP_API_KEY = Rails.application.credentials.yelp[:api_key]
FOURSQUARE_CLIENT_ID = Rails.application.credentials.foursquare[:client_id]
FOURSQUARE_CLIENT_SECRET = Rails.application.credentials.foursquare[:client_secret]
ZOMATO_USER_KEY = Rails.application.credentials.zomato[:user_key]

class Restaurant < ApplicationRecord
  has_many :reviews
  belongs_to :third_party_rating, required: false

  def set_third_party_rating(platform, force = false)
    rating = ""

    if self.third_party_rating
      # puts "RATING OBJ EXISTS"
      rating = self.third_party_rating
      if !rating[platform] || force == true
        rating[platform] = associate_platform(platform)
        rating.save
      end
      # if rating[platform]
      #   # puts "#{platform} RATING EXISTS"
      # else
      #   rating[platform] = associate_platform(platform)
      #   rating.save
      #   # puts "NEW RATING TYPE #{platform}"
      # end
    else
      rating = ThirdPartyRating.new
      rating[platform] = associate_platform(platform)
      rating.save

      self.third_party_rating = rating
      self.save
      # puts "NEW RATING OBJECT"
    end

    rating
  end

  private

  def associate_platform(platform)
    case platform
      when "yelp"
        associate_yelp
      when "foursquare"
        associate_foursquare
      when "googleplaces"
        associate_googleplaces
      when "zomato"
        associate_zomato
      else
    end
  end

  def associate_yelp
    term = self.name.parameterize
    lat = self.lat
    lng = self.lng
    limit = 1
    categories = "restaurants, All"
    url = "https://api.yelp.com/v3/businesses/search?term=#{term}&latitude=#{lat}&longitude=#{lng}&limit=#{limit}&categories=#{categories}"
    headers = { :Authorization => "Bearer #{YELP_API_KEY}" }

    response = JSON.parse(RestClient.get url, headers)

    if response["businesses"].length > 0
      self.yelp_url = response["businesses"].first["url"]
      self.yelp_id = response["businesses"].first["id"]
      self.save

      if response["businesses"].first["rating"]
        response["businesses"].first["rating"]
      else
        0
      end
    else
      0
    end
  end

  def associate_foursquare
    v = "20180928"
    ll = "#{self.lat},#{self.lng}"
    intent = "match"
    limit = 1
    name = self.name.parameterize

    url = "https://api.foursquare.com/v2/venues/search?client_id=#{FOURSQUARE_CLIENT_ID}&client_secret=#{FOURSQUARE_CLIENT_SECRET}&v=#{v}&ll=#{ll}&intent=#{intent}&limit=#{limit}&name=#{name}"
    response = JSON.parse(RestClient.get url)

    if response["response"]["venues"].length > 0
      foursquare_id = response["response"]["venues"].first["id"]
      self.foursquare_id = foursquare_id

      details_url = "https://api.foursquare.com/v2/venues/#{foursquare_id}?client_id=#{FOURSQUARE_CLIENT_ID}&client_secret=#{FOURSQUARE_CLIENT_SECRET}&v=#{v}"
      details_response = JSON.parse(RestClient.get details_url)
      self.foursquare_url = details_response["response"]["venue"]["canonicalUrl"]
      self.save

      if details_response["response"]["venue"]["rating"]
        details_response["response"]["venue"]["rating"]
      else
        0
      end
    else
      0
    end
  end

  def associate_googleplaces
    response = Geocoder.search(self.google_places_id).first
    if response.data.length > 0
    #   self.googleplaces_url = response.data["url"]
    #   self.save
      if response.data["rating"]
        response.data["rating"]
      else
        0
      end
    else
      0
    end
  end

  def associate_zomato
    q = self.name.parameterize
    lat = self.lat
    lon = self.lng
    count = 1
    radius = 30
    sort = "real_distance"
    url = "https://developers.zomato.com/api/v2.1/search?q=#{q}&lat=#{lat}&lon=#{lon}&radius=#{radius}&count=#{count}&sort=#{sort}"
    headers = { "user-key": ZOMATO_USER_KEY }
    response = JSON.parse(RestClient.get url, headers)
    if response["restaurants"].length > 0
      self.zomato_url = response["restaurants"].first["restaurant"]["url"]
      self.zomato_id = response["restaurants"].first["restaurant"]["id"]
      self.save

      response["restaurants"].first["restaurant"]["user_rating"]["aggregate_rating"]
    else
      0
    end
  end

end
