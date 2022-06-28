require 'menu'

describe Menu do 
  context 'return the function in the principal menu' do 
    it 'raise and error if is not a valid number' do
      fake_menu = double(:fake_menu)
      expect(fake_menu).to receive(:puts).with("Please select the number relative of what you would like to choose:")
      expect(fake_menu).to receive(:puts).with("1. Main course\n2. Dessert\n3. Drinks\n9. Check Out")
      expect(fake_menu).to receive(:gets).and_return("4")
      expect(fake_menu).to receive(:puts).with "This is not a valid number. Please, try again"

      menu = Menu.new(fake_menu)
      menu.principal_menu
    end
  end
end

describe 'integration' do
  context 'going to check out from main course' do
    it 'nothing choose' do
      fake_menu = double(:fake_menu)
      expect(fake_menu).to receive(:puts).with("Please select the number relative of the main course to add:")
      expect(fake_menu).to receive(:puts).with("1. Feijoada - £10")
      expect(fake_menu).to receive(:puts).with("2. Moqueca (Fish Stew) - £12")
      expect(fake_menu).to receive(:puts).with("3. Sirloin Steak - £14")
      expect(fake_menu).to receive(:puts).with("9. I don't want any more main course. Go to Principal Menu")
      expect(fake_menu).to receive(:gets).and_return("9")

      expect(fake_menu).to receive(:puts).with("Please select the number relative of what you would like to choose:")
      expect(fake_menu).to receive(:puts).with("1. Main course\n2. Dessert\n3. Drinks\n9. Check Out")
      expect(fake_menu).to receive(:gets).and_return("9")
      expect(fake_menu).to receive(:puts).with("This is your order: .")
      menu = Menu.new(fake_menu)
      menu.main_course
    end

    it 'something added in the list' do
      fake_menu = double(:fake_menu)
      expect(fake_menu).to receive(:puts).with("Please select the number relative of the main course to add:")
      expect(fake_menu).to receive(:puts).with("1. Feijoada - £10")
      expect(fake_menu).to receive(:puts).with("2. Moqueca (Fish Stew) - £12")
      expect(fake_menu).to receive(:puts).with("3. Sirloin Steak - £14")
      expect(fake_menu).to receive(:puts).with("9. I don't want any more main course. Go to Principal Menu")
      expect(fake_menu).to receive(:gets).and_return("1")

      expect(fake_menu).to receive(:puts).with("Please select the number relative of the main course to add:")
      expect(fake_menu).to receive(:puts).with("1. Feijoada - £10")
      expect(fake_menu).to receive(:puts).with("2. Moqueca (Fish Stew) - £12")
      expect(fake_menu).to receive(:puts).with("3. Sirloin Steak - £14")
      expect(fake_menu).to receive(:puts).with("9. I don't want any more main course. Go to Principal Menu")
      expect(fake_menu).to receive(:gets).and_return("9")

      expect(fake_menu).to receive(:puts).with("Please select the number relative of what you would like to choose:")
      expect(fake_menu).to receive(:puts).with("1. Main course\n2. Dessert\n3. Drinks\n9. Check Out")
      expect(fake_menu).to receive(:gets).and_return("9")
      expect(fake_menu).to receive(:puts).with('This is your order: [["Feijoada", 10]].')

      menu = Menu.new(fake_menu)
      menu.main_course
    end
  end
end
