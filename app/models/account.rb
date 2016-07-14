class Account < ApplicationRecord
  has_many :histories
  has_many :messages

  validates :phone, presence: true, uniqueness: true
end
