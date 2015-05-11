class User < ActiveRecord::Base

	validates :username, presence: true
	validates :phone_number, presence: true
	has_secure_password
end


