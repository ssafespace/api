class Topic < ApplicationRecord
  has_many :histories

  validates :name, presence: true, uniqueness: true
end
