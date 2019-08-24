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
    @service ||= client.proxy.services(service_sid)
  end

  def add_number(phone_sid:)
    service.phone_numbers.create(sid: phone_sid)
  end

  def create_session(unique_name:, sender_number:, recipient_number:)
    session = service.sessions.create(
      unique_name: unique_name
    )

    add_participants_to_session(session_sid: session.sid, sender_number: sender_number , recipient_number: recipient_number)

    session_hash = {}
    session_hash['session_sid'] = session.sid
    session_hash['sender_sid'] = service.sessions(session.sid).participants.list.select{|pr| pr.friendly_name == 'Sender'}[0].sid
    session_hash['recipient_sid'] = service.sessions(session.sid).participants.list.select{|pr| pr.friendly_name == 'Recipient'}[0].sid
    session_hash
  end

  def send_message(session_sid:, sender_sid:, message_text:)
    service.sessions(session_sid).participants(sender_sid).message_interactions.create(body: message_text)
  end

  def print_interactions(session_sid:)
    interactions = service.sessions(session_sid).interactions.list(limit:20)

    interactions.each do |record|
      puts JSON.parse(record.data)["body"]
    end
  end

  private

  def add_participants_to_session(session_sid:, sender_number:, recipient_number:)
    add_participant(session_sid: session_sid, friendly_name: 'Sender', phone_number: sender_number)
    add_participant(session_sid: session_sid, friendly_name: 'Recipient', phone_number: recipient_number)
  end

  def add_participant(session_sid:, friendly_name:, phone_number:)
    service.sessions(session_sid).participants.create(
      friendly_name: friendly_name,
      identifier: phone_number
    )
  end
end
