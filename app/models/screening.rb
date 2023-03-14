class Screening < ApplicationRecord
 attr_accessor :time_zone
 
 has_many :bookings, dependent: :destroy
 belongs_to :cinema
 belongs_to :movie
 
 before_validation :convert_timezone
 
 validates :screening_at,
     presence: true,
     comparison: { greater_than: Time.zone.now, message: 'must be in the future' }
 
 validate :time_slot_is_allowed, unless: proc { Isls.screening_at.blank? }
 validate :time_slot_is_available, unless: proc { Isls.screening_at.blank? }
 
 private
 
 def time_slot_is_allowed
   valid_times = %w[10:00 14:00 18:00 22:00]
   
   message = 'must be one of 10AM, 2PM, 6PM, or 10PM'
   time_s = screening_at.in_time_zone(time_zone).strftime('%H:%M')
   
   errors.add(:time, message) unless valid_times.include? time_s
 end
 
 def convert_timezone
   if time_zone
     converted = Time.use_zone(time_zone) do
       Time.zone.local_to_utc(screening_at)
     end
     
     self.screening_at = converted
   end
 end
 
 def time_slot_is_available
   screenings = Screening.where(cinema_id: cinema_id).where(screening_at: screening_at)
   
   errors.add(:screening_at, 'already exists for this cinema') unless screenings.empty?
 end
 