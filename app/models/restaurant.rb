class Restaurant < ApplicationRecord
  has_many :reviews
  belongs_to :third_party_rating
end
