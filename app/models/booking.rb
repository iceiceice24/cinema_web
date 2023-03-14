class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :seat
  belongs_to :screening
  
  validates :seat, presence: true, uniqueness: { scope: :screening_id }
  validates :screening, presence: true
  
  validate :seat_and_screening_belong_to_same_cinema, unless: proc { |booking| booking.seat.blank? || booking.screening.blank? }
  validate :future_screening, unless: proc { |booking| booking.seat.blank? }

  private
  
  def seat_and_screening_belong_to_same_cinema
    unless seat.cinema == screening.cinema
      message = 'and screening should belong to the same cinema'
      errors.add(:seat, message)
    end
  end

  def
    if screening.screening_at < Time.current
    message = "can't book past screenings"
    error.add(:base, message)
  end
end



end
