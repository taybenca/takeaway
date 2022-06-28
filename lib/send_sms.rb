# Download the helper library from https://www.twilio.com/docs/ruby/install
require 'rubygems'
require 'twilio-ruby'

# Find your Account SID and Auth Token at twilio.com/console
# and set the environment variables. See http://twil.io/secure
account_sid = 
auth_token = 
@client = Twilio::REST::Client.new(account_sid, auth_token)

message = @client.messages
  .create(
     body: 'Thank you! Your order was placed and will be delivered before...'
     from: '+18599558642',
     to: '+447472956139'
   )

puts message.sid