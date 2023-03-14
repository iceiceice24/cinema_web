class User < ApplicationRecord
    has_secure_password

    before_save :downcase_email

    validates :name, presence: true, lenght: { maximum: 50 }    
    valid_email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, uniqueness: true,
                      presence: true

    validates :password, length: { minimum: 5, allow_nil: true }

    validates :mobile_number, presence: true

end
