require_relative '../environment'
require 'interfaces/sms_interface'

*args = ARGV

Interface::SmsInterface.create_service(uniq_name: args[0])
