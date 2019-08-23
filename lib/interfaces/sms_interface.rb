require 'models/twilio_client'

module Interface
  class SmsInterface
    attr_reader :twilio_client
    attr_reader :service_sid

    def initialize
      @service_sid = IO.readlines("service_sid.txt").last.strip!
      @twilio_client = TwilioClient.new(service_sid: @service_sid)
    end

    def self.create_service(uniq_name:)
      service = self.new.twilio_client.create_service(uniq_name: uniq_name)
      File.open('service_sid.txt', "a") { |f| f.puts service.sid }
    end

    def add_number_to_service(phone_number_sid:)
      twilio_client.add_number(phone_sid: phone_number_sid)
    end
  end
end
