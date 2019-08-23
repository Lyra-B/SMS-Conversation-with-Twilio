require 'twilio-ruby'

class TwilioClient
  CONFIG = JSON.parse(File.read(ENV['HOME']+'/.twilio_config.json'))
  ACCOUNT_SID = CONFIG["twilio"]["account_sid"]
  AUTH_TOKEN = CONFIG["twilio"]["auth_token"]

  attr_reader :client
  attr_reader :service_sid

  def initialize(service_sid: nil)
    @client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
    @service_sid = service_sid
  end

  def create_service(uniq_name:)
    client.proxy.services.create(unique_name: uniq_name)
  end

  def service
    client.proxy.services(service_sid)
  end

  def add_number(phone_sid:)
    service.phone_numbers.create(sid: phone_sid)
  end
end
