require_relative '../environment'
require 'interfaces/sms_interface'

*args = ARGV

sms_interface = Interface::SmsInterface.new

session = sms_interface.create_session(unique_name: args[0], sender_number: args[1], recipient_number: args[2])

sms_interface.send_message(session_sid: session["session_sid"], sender_sid: session["sender_sid"], message_text: args[3])

puts session["session_sid"]
