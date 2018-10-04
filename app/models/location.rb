class Location < ApplicationRecord
  validates :name, :address, presence: true, uniqueness: true
  validates :name, length: { in: 2..50 }
  validates :address, length: { in: 10..100 }
end
