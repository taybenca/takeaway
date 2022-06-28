require 'order'

describe Order do
  it 'returns the format of the menu' do
    order = Order.new(Kernel)
    menu = {"Steak" => 14}
    result = order.format(menu)
    expect(result).to eq menu
  end

  it 'choose one item and return the list' do
    fake_order = double(:fake_menu, gets: "Feijoada")
    expect(fake_order).to receive(:gets).and_return("Feijoada")
    expect(fake_order).to receive(:gets).and_return("Mango Juice")
    expect(fake_order).to receive(:gets).and_return("0")
    order = Order.new(fake_order)
    order.choose_order
  end

  xit 'send sms after order is completed' do
    fake_sms = double(:fake_sms)
    time_format = (Time.now+1800).strftime("%k:%M")
    expect(fake_sms).to receive(:criate)
      .with(body: "Thank you! Your order was placed and will be delivered before #{time_format}",
      from: '+18599558642',
      to: '+447472956139')
    order = Order.new(fake_sms)
    order.send_sms
  end

  it 'delete an item' do
    fake_item = double(:fake_item, gets: "Cake")
    expect(fake_item).to receive(:gets).and_return("Cake")
    order = Order.new(fake_item)
    order.delete
  end

  it 'check the delivery time' do
    fake_time = double(:fake_time)
    fake_time = Time.new(2022, 6, 28, 12, 14, 33)+1800
    result = fake_time.strftime("%k:%M")
    expect(result).to eq "12:44"
    order = Order.new(fake_time)
    order.time_format
  end
end