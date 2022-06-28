# Download the helper library from https://www.twilio.com/docs/ruby/install
require 'rubygems'
require 'twilio-ruby'

# # Find your Account SID and Auth Token at twilio.com/console
# # and set the environment variables. See http://twil.io/secure
# account_sid = 
# auth_token = 
# @client = Twilio::REST::Client.new(account_sid, auth_token)

# message = @client.messages
#   .create(
#      body: 'Thank you!'
#      from: '+18599558642',
#      to: '+44'
#    )

# puts message.sid

class Order
  def initialize(order)
    @order = order
    @chosen_itens = []
    @menu = {"Steak" => 14, "Feijoada" => 10, "Moqueca" => 12, "Passion Fruit Cream" => 4, "Cake" => 5, "Brigadeiro" => 2, "Mango Juice" => 5, "Coffee" => 3, "Caipirinha" => 6}
    @chosen_itens_with_price = Hash.new
  end

  def format(hash)
    hash.each do |key, value|
      puts "#{key} - £#{value}"
    end
  end 

  def choose_order
    user_input = nil
    puts "Welcome to the Brazilian Restaurant"
    puts "Please write the item you'd like to order:"
    format(@menu)
    puts "For checkout, press 0"
    # The user can add other itens and when they finishes, they press 0.
    # chosen_itens is a array with keys
    while user_input != "0" do
      user_input = @order.gets.chomp
      @chosen_itens << user_input if @menu.include?(user_input)
    end
      # Now we need to find the value of each key listed an add in a new hash
    @chosen_itens.each do |item| 
    @chosen_itens_with_price.merge!(
      @menu.select do |key, value|
        key.include?(item)
      end)
    end
    checkout
  end

  def checkout
    puts "Your order:"
    format(@chosen_itens_with_price)
    total
    puts "Press 1 to confirm, 2 to delete or 3 to add"
    user_input = @order.gets.chomp
    case user_input
    when "1"
      send_sms
    when "2"
      delete
    when "3"
      choose_order
    end
  end

  def total
    total_price = []
    @chosen_itens_with_price.each do |key, value|
      total_price << value
    end
    puts "\nTotal: £#{total_price.sum}"
  end

  def time_format
    @time = Time.now + 1800
    @time.strftime("%k:%M")
    # to add some time, this time should be in seconds.
    # 30 minutes is the time to prepare the food and deliver it
    # 30 min == 1800 sec
  end

  def send_sms
    account_sid = "ACf344404d7e7ddf394343a8de6225b7b4"
    auth_token = "98b7f51f69fb444187db7a47f74dc9bc"
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    message = @client.messages
      .create(
        body: "Thank you! Your order was placed and will be delivered before #{time_format}",
        from: '+18599558642',
        to: '+447472956139'
      )
    puts message.sid
  end

  def delete
    puts "Please write the item to delete:"
    format(@chosen_itens_with_price)
    user_input = @order.gets.chomp
    @chosen_itens.delete(user_input)
    @chosen_itens_with_price.delete(user_input)
    checkout
  end
end

order = Order.new(Kernel)
order.choose_order
