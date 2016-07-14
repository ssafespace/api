class History < ApplicationRecord
  has_many :messages
  belongs_to :host, class_name: "Account"
  belongs_to :guest, class_name: "Account"

  validates :messages, presence: true
  validates :host, presence: true
  validates :guest, presence: true
  validate :twosided


  private def twosided
    if host_id == guest_id
      errors.add(:twosided, "conversations require two different people")
    end
  end
end
