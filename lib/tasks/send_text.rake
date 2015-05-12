namespace :send_text do
	desc "this should send a text if time of text lesser or equal to now"
	task :send_text => :environment do
		appointment = Appointment.all 
		appointment.each do |appointment|
				p appointment.time.in_time_zone("Eastern Time (US & Canada)")
				p Time.now

				if appointment.time.in_time_zone("Eastern Time (US & Canada)") <= Time.now
					appointment.reminder
					appointment.delete
				else

				end
			
			 
		end
	end
end