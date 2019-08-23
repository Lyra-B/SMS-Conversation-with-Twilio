require_relative '../environment'
require 'interfaces/sms_interface'

Interface::SmsInterface.create_service(uniq_name: 'my_twilio_service')
