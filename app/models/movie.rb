class Movie < ApplicationRecord
    validates :title, presence: true, length: { maximum: 166 }
end
