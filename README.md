# Twilio Proxy Integration Example

### Getting Started

* git clone
* bundle install

### Set up the Environment

* To run this app you will need to have a twilio account and a subaccount and be able to access the twilio api through the twilio console

* Furthermore, you will need to buy at least one twilio powered phone number to populate the Proxy Number Pool. This number can't be used for any other processes. As soon as you have a number available, take a note for the phone_number's sid
Click [here](https://www.twilio.com/docs/proxy/quickstart#purchase-a-twilio-phone-number) for more info

* Last, you will need to create a file at your local directory and add your twilio credentials(account_sid, auth_token), with the name ".twilio_config.json"


```
{
  "twilio":
    {
      "account_sid": "ACXXXXXXXXXXXXXXXXXXXXXXX",
      "auth_token": "aXXXXXXXXXXXXXXXXXXXXXXXXX",
    }
}
```

### Make an SMS conversation

As soon as the above are set up you should be able to do the following by running these commands in your local directory of the app

* Create a service (pass a name for your service)

        ruby lib/create_service.rb 'name_of_service'

* Add a number to the Proxy Service Number Pool(pass the phone number sid acquired when you bought the number )

        ruby lib/add_number_to_service.rb PNXXXXXXXXXXXXXXX

*  Create a Session and start the SMS conversation (pass the unique name of this session, the phone number of the sender, the phone number of the recipient and the message you want to send)

        ruby lib/create_sms_conversation.rb MySmsConversation +44000XXXXXXX +44000XXXXXXX Hello

 * Take a note of the output of this command, it is the session's sid and you will need it for later
 * You can continue this conversation through your phones

*  See the log of your conversation(pass the session sid acquired from the last command)

       ruby print_interaction KCXXXXXXXXXXXXXXXXXX
