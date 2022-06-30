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
#      from: '',
#      to: '+44'
#    )

# puts message.sid

class Order
  def initialize(order)
    @order = order
    @chosen_items = Array.new
    @menu = {"Steak" => 14, "Feijoada" => 10, "Moqueca" => 12, "Passion Fruit Cream" => 4, "Cake" => 5, "Brigadeiro" => 2, "Mango Juice" => 5, "Coffee" => 3, "Caipirinha" => 6}
    @chosen_items_with_price = Hash.new
    puts "\nWelcome to the Brazilian Restaurant"
  end

  def format(hash)
    hash.each do |key, value|
      puts "#{key} - £#{value}"
    end
  end 

  def choose_order
    user_input = nil
    puts "\nPlease write the item you'd like to order:"
    format(@menu)
    puts "\nFor checkout, press 0"
    # The user can add other items and when they finishes, they press 0.
    # chosen_items is a array with keys
    while user_input != "0" do
      user_input = @order.gets.chomp
      @chosen_items << user_input if @menu.include?(user_input)
    end
      # Now we need to find the value of each key listed an add in a new hash
    @chosen_items.each do |item|  #["Feijoada", "Moqueca"]
    @chosen_items_with_price.merge!(
      @menu.select do |key, value|
        key.include?(item)
      end)
    end
    checkout
  end

  def checkout
    puts "\nYour order:"
    format(@chosen_items_with_price)
    total
    puts "\nPress 1 to confirm, 2 to delete or 3 to add"
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
    @chosen_items_with_price.each do |key, value|
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
    puts "\nThank you for your order!"
    puts "Receive your order in 30 minutes or your money back"
    account_sid = "account_number"
    auth_token = "auth_token"
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    message = @client.messages
      .create(
        body: "Thank you! Your order was placed and will be delivered before #{time_format}",
        from: 'twilio_number',
        to: 'your_number'
      )
    puts message.sid
  end

  def delete
    puts "\nPlease write the item to delete:\n"
    format(@chosen_items_with_price)
    user_input = @order.gets.chomp
    @chosen_items.delete(user_input)
    @chosen_items_with_price.delete(user_input)
    checkout
  end
end

order = Order.new(Kernel)
order.choose_order
