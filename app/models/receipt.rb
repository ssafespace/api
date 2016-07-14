class Receipt < ApplicationRecord
  belongs_to :message
  belongs_to :history
  belongs_to :account

  validates :message, presence: true
  validates :history, presence: true
  validates :account, presence: true
end
