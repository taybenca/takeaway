require 'order'

describe Order do
  it 'returns the format of the menu' do
    order = Order.new(Kernel)
    expect(order.format(Kernel)).to eq "Steak" => 14, "Feijoada" => 10, "Moqueca" => 12, "Cake" => 5, "Juice" => 5, "Caipirinha" => 6
  end

  it 'choose one item and return the list' do
    fake_order = double(:fake_menu)
    expect(fake_order).to receive(:gets).and_return("Feijoada")
    expect(fake_order).to receive(:gets).and_return("Juice")
    expect(fake_order).to receive(:gets).and_return("0")
    order = Order.new(fake_order)
    order.choose_order
    order.checkout
  end
end