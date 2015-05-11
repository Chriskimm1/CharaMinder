require 'net/http'

class Appointment < ActiveRecord::Base
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :time, presence: true

  before_save :yoda_speak

  @@REMINDER_TIME = 30.minutes # minutes before appointment

  # Notify our appointment attendee X minutes before the appointment time
  def reminder
    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    time_str = ((self.time).localtime).strftime("%I:%M%p on %b. %d, %Y")
    tell_yoda = self.tell_yoda
    message = @client.account.messages.create(
      :from => @twilio_number,
      :to => self.phone_number,
      :body => tell_yoda,
    )
    puts message.to
  end

  def when_to_run
    time - @@REMINDER_TIME
  end

  def yoda_speak
    response = URI.escape("https://yoda.p.mashape.com/yoda?sentence=#{self.tell_yoda}") ,
  headers:{
    "X-Mashape-Key" => "8khpGVGeKFmshim81WAJlEshvCRIp1nXpdLjsn8J1tj7vubgo6",
    "Accept" => "text/plain"
  }
  end

  handle_asynchronously :reminder, :run_at => Proc.new { |i| i.when_to_run }
end

