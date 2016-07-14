class Location < ApplicationRecord
  belongs_to :history
  belongs_to :account

  validates :history, presence: true
  validates :account, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
