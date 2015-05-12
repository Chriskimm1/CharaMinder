require 'net/http'

class Appointment < ActiveRecord::Base
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :time, presence: true
  
  before_save :yoda_speak
  
  # @@REMINDER_TIME = 3.minutes # minutes before appointment

  # Notify our appointment attendee X minutes before the appointment time
  def reminder 
    @twilio_number = ENV["TWILIO_NUMBER"]
    account_sid = ENV["SID"]
    auth_token = ENV["TOKEN"]
    @client = Twilio::REST::Client.new account_sid, auth_token
    time_str = ((self.time).localtime).strftime("%I:%M%p on %b. %d, %Y")
    message = @client.account.messages.create(
      :from => @twilio_number,
      :to => self.phone_number,
      :body => tell_yoda,
    )
    puts message.to
  end

  

  def yoda_speak

    response = Unirest.get "https://yoda.p.mashape.com/yoda?sentence=yoda says: #{self.tell_yoda}" ,
              headers:{
                "X-Mashape-Key" => "8khpGVGeKFmshim81WAJlEshvCRIp1nXpdLjsn8J1tj7vubgo6",
                "Accept" => "text/plain"
              }
    self.tell_yoda = response.body 

  end

  

# def when_to_run
#     binding.pry
#    set_time = time.utc - @@REMINDER_TIME

#   end

#   handle_asynchronously :reminder, :run_at => Proc.new { |i| i.when_to_run }


end
