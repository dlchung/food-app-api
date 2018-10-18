GOOGLE_PLACES_API_KEY = Rails.application.credentials.google[:places][:api_key]
YELP_API_KEY = Rails.application.credentials.yelp[:api_key]
FOURSQUARE_CLIENT_ID = Rails.application.credentials.foursquare[:client_id]
FOURSQUARE_CLIENT_SECRET = Rails.application.credentials.foursquare[:client_secret]
ZOMATO_USER_KEY = Rails.application.credentials.zomato[:user_key]

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
