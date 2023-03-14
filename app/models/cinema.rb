class Cinema < ApplicationRecord
  DEFAULT_SEAT_COUNT = 10

  has_many :seats, dependent: :destroy

  validates :name, presence: true, length: { maximum: 166 }
end
