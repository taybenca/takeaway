# Download the helper library from https://www.twilio.com/docs/ruby/install
require 'rubygems'
require 'twilio-ruby'
@time = Time.now + 30
# Find your Account SID and Auth Token at twilio.com/console
# and set the environment variables. See http://twil.io/secure
account_sid = "ACf344404d7e7ddf394343a8de6225b7b4"
auth_token = "5098372423290039acab873d6eff16e9"
@client = Twilio::REST::Client.new(account_sid, auth_token)

message = @client.messages
  .create(
     body: 'Thank you! Your order was placed and will be delivered before #{@time}',
     from: '+18599558642',
     to: '+447472956139'
   )

puts message.sid