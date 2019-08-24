require './environment'
require 'interfaces/sms_interface'

*args = ARGV

sms_interface = Interface::SmsInterface.new

sms_interface.print_interactions(session_sid: args[0])
