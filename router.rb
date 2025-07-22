class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @running = true
  end

  def run
    while @running
      @current_user = @sessions_controller.login
      while @current_user
        # authenticate the user (sessions controller#login)

        # if the authenticated user is rider
        if @current_user.rider?
          # display rider menu
          display_rider_menu
          # get choice
          choice = gets.chomp.to_i
          # route to correct controller
          rider_action(choice)
        else
          # if the authenticated user is manager
          # display manager menu
          display_manager_menu
          # get choice
          choice = gets.chomp.to_i
          # route to correct controller
          manager_action(choice)
        end

      end
    end
  end

  private

  def display_rider_menu
    puts "------------------------------"
    puts "------ 🛵 RIDER MENU 🛵 -------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - Mark order as delivered"
    puts "2 - List all my undelivered orders"
    puts "8 - Log out"
    puts "9 - Quit"
    print "> "
  end

  def display_manager_menu
    puts "------------------------------"
    puts "----👩‍💼 MANAGER MENU 👩‍💼 --------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - List all meals"
    puts "2 - Add a meal"
    puts "3 - List all customers"
    puts "4 - Add a customer"
    puts "5 - Add a new order"
    puts "6 - List all undelivered orders"
    puts "8 - Log out"
    puts "9 - Quit"
    print "> "
  end

  def get_choice
    gets.chomp.to_i
  end

  def rider_action(choice)
    case choice
    # when 1 then @orders_controller.list_my_orders(@current_user)
    # when 2 then @orders_controller.mark_as_delivered

    when 8 then logout
    when 9 then quit
    else
      puts "Try again..."
    end
  end

  def manager_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    # when 5 then @orders_controller.add
    # when 6 then @orders_controller.list_undelivered_orders

    when 8 then logout
    when 9 then quit
    else
      puts "Try again..."
    end
  end

  def logout
    # Unset the current user
    @current_user = nil
  end

  def quit
    # log out the user
    logout
    # Set the running to false
    @running = false
  end
end
