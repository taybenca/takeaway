class Menu 
  def initialize(menu)
    @menu = menu
    @chosen_itens = []
    @checkout = false
  end

  def principal_menu
    @menu.puts "Please select the number relative of what you would like to choose:"
    @menu.puts "1. Main course\n2. Dessert\n3. Drinks\n9. Check Out"
    user_input = @menu.gets.chomp
    while true do
      case user_input
        when "1"
          main_course()
        when "2"
          dessert()
        when "3"
          drinks()
        when "9"
          @checkout = true
          show()
        else
          @menu.puts "This is not a valid number. Please, try again"
      end
      break
    end
  end

  def main_course
    index = 1
    itens = {"Feijoada" => 10, 
      "Moqueca (Fish Stew)" => 12, 
      "Sirloin Steak" => 14
    }
    @menu.puts "Please select the number relative of the main course to add:"
    itens.each do |key, value|
      @menu.puts "#{index}. #{key} - £#{value}"
    index += 1
    end
    @menu.puts "9. I don't want any more main course. Go to Principal Menu"
    user_input = @menu.gets.chomp
    case user_input
      when "1"
        @chosen_itens << itens.to_a.at(0)
        main_course()
      when "2"
        @chosen_itens << itens.to_a.at(1)
        main_course()
      when "3"
        @chosen_itens << itens.to_a.at(2)
        main_course()
      when "9"
        principal_menu()
      else
        @menu.puts "This is not a valid number. Please, try again"
        main_course()
      end
  end

  def dessert
    @menu.puts "Please select the number relative of the dessert to add:"
    index = 1
    itens = {"Brigadeiro" => 3, 
      "Passion fruit ice cream" => 5, 
      "Mango cream" => 5
    }
    itens.each do |key, value|
      @menu.puts "#{index}. #{key} - £#{value}"
    index += 1
    end
    @menu.puts "9. I don't want any more dessert. Go to Principal Menu"
    user_input = @menu.gets.chomp
    case user_input
      when "1"
        @chosen_itens << itens.to_a.at(0)
        dessert()
      when "2"
        @chosen_itens << itens.to_a.at(1)
        dessert()
      when "3"
        @chosen_itens << itens.to_a.at(2)
        dessert()
      when "9"
        principal_menu()
      else
        @menu.puts "This is not a valid number. Please, try again"
        dessert()
      end
  end

  def drinks
    @menu.puts "Please select the number relative of the drinks to add:"
    index = 1
    itens = {"Coffee" => 3, 
      "Caipirinha" => 5, 
      "Cashew Juice" => 5
    }
    itens.each do |key, value|
      @menu.puts "#{index}. #{key} - £#{value}"
    index += 1
    end
    @menu.puts "9. I don't want any more drinks. Go to Principal Menu"
    user_input = @menu.gets.chomp
    case user_input
      when "1"
        @chosen_itens << itens.to_a.at(0)
        drinks()
      when "2"
        @chosen_itens << itens.to_a.at(1)
        drinks()
      when "3"
        @chosen_itens << itens.to_a.at(2)
        drinks()
      when "9"
        principal_menu()
      else
        @menu.puts "This is not a valid number. Please, try again"
        drinks()
      end
  end

  def show
    puts "This is your order: #{@chosen_itens}."
  end
end

menu = Menu.new(Kernel)
menu.principal_menu