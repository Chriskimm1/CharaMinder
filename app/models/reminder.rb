class Reminder < ActiveRecord::Base

	validates :name, presence: true
	validates :phone_number, presence: true
	validates :time, presence: true
	validates :reminder, presence: true

end