require 'yelp/fusion'

YELP_API_KEY = Rails.application.credentials.yelp[:api_key]

class ThirdPartyRatingsController < ApplicationController
  def get_yelp_rating
    yelp = Yelp::Fusion::Client.new(YELP_API_KEY)
    puts yelp.business('ChIJ2QZOdTpawokRU_eN_EPJaX8')
  end
end
