class Message < ApplicationRecord
  has_many :locations
  has_many :reciepts
  belongs_to :account
  belongs_to :history

  validates :account, presence: true
  validates :history, presence: true
  validates :receipts, presence: true
  validates :body, presence: true, length: {min: 1}
end
