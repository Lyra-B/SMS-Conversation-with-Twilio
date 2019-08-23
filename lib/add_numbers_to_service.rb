require './environment'
require 'interfaces/sms_interface'

*phone_number_sids = ARGV

interface = Interface::SmsInterface.new

phone_number_sids.each do |sid|
  interface.add_number_to_service(phone_number_sid: sid)
end
