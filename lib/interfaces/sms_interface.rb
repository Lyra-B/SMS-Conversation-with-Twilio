require 'models/twilio_client'

module Interface
  class SmsInterface
    SERVICE_SID_FILE = "service_sid.txt"

    attr_reader :twilio_client
    attr_reader :service_sid

    def initialize
      @service_sid = fetch_service_sid
      @twilio_client = TwilioClient.new(service_sid: @service_sid)
    end

    def self.create_service(uniq_name:)
      service = self.new.twilio_client.create_service(uniq_name: uniq_name)
      File.open('service_sid.txt', "a") { |f| f.puts service.sid }
    end

    def add_number_to_service(phone_number_sid:)
      twilio_client.add_number(phone_sid: phone_number_sid)
    end

    def create_session(unique_name:, sender_number:, recipient_number:)
      twilio_client.create_session(unique_name: unique_name, sender_number: sender_number, recipient_number: recipient_number)
    end

    def send_message(session_sid:, sender_sid:, message_text:)
      twilio_client.send_message(session_sid: session_sid, sender_sid: sender_sid, message_text: message_text)
    end

    def print_interactions(session_sid:)
      twilio_client.print_interactions(session_sid: session_sid)
    end

    private

    def fetch_service_sid
      if File.exist?(SERVICE_SID_FILE)
        IO.readlines(SERVICE_SID_FILE).last.strip!
      end
    end
  end
end
