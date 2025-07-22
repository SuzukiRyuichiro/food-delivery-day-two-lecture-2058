require_relative '../views/employee_view'
require_relative '../views/order_view'
require_relative '../views/meal_view'
require_relative '../views/customer_view'
require_relative '../models/order'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository

    @employee_view = EmployeeView.new
    @order_view = OrderView.new
    @meal_view = MealView.new
    @customer_view = CustomerView.new
  end

  def add
    # Display all riders
    riders = @employee_repository.all_riders
    @employee_view.display(riders)

    # ask the user for who's delivering
    rider_index = @order_view.ask_for_index
    employee = riders[rider_index]

    # Display all customers
    customers = @customer_repository.all
    @customer_view.display(customers)
    # ask the user for customer
    customer_index = @order_view.ask_for_index
    customer = customers[customer_index]

    # Display all meals
    meals = @meal_repository.all
    @meal_view.display(meals)
    # ask the user for meal
    meal_index = @order_view.ask_for_index
    meal = meals[meal_index]

    # Create an instance of order
    order = Order.new(meal: meal, customer: customer, employee: employee)
    # Save them in repository
    @order_repository.create(order)
  end

  def list_undelivered_orders
    # ask order repository for undelivered orders
    orders = @order_repository.undelivered_orders
    # ask view to display all orders
    @order_view.display(orders)
  end

  def list_my_orders(employee)
    # ask order repository to give back instances of orders
    orders = @order_repository.my_orders(employee)
    @order_view.display(orders)
  end

  def mark_as_delivered(employee)
    # get my undelivered orders from repository
    # display them
    orders = @order_repository.my_orders(employee)
    @order_view.display(orders)
    # ask for index
    index = @order_view.ask_for_index
    # mark that instance as delivered
    order_to_mark_as_delivered = orders[index]
    # save that updated instance in repository
    @order_repository.mark_as_delivered(order_to_mark_as_delivered)
  end
end
