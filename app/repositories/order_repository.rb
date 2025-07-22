require 'csv'
require_relative '../models/order'

class OrderRepository
  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @csv_file_path = csv_file_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository

    @next_id = 1

    @orders = []
    load_csv if File.exist?(@csv_file_path)
  end

  def create(order) # expect instance of Order
    # Assign the order with next id
    order.id = @next_id
    # Push the order into @orders array
    @orders << order
    # increment the next id
    @next_id += 1
    # save the csv
    save_csv
  end

  def undelivered_orders
    # return all undelivered orders
    @orders.reject { |order| order.delivered? }
  end

  def my_orders(employee)
    # Select all undelivered orders
    orders = undelivered_orders
    # Select all orders assigned to the given employee
    orders.select { |order| order.employee == employee }
  end

  def mark_as_delivered(order)
    # Switch the @delivered to true
    order.deliver!
    # save to CSV
    save_csv
  end

  private

  def load_csv
    # Open the csv file
    CSV.foreach(@csv_file_path, headers: true, header_converters: :symbol) do |row|
      # iterate over each row
      # convert id to integer
      row[:id] = row[:id].to_i
      # converted delivered to boolean
      row[:delivered] = row[:delivered] == 'true'
      # Find Meal instance with the given meal_id
      row[:meal] = @meal_repository.find(row[:meal_id].to_i)
      # Find Customer instance with the given meal_id
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      # Find Employee instance with the given meal_id
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)
      # make an instance of Order based on row information
      # put the instance into @orders array
      @orders << Order.new(row)
    end

    # determine the next_id
    @next_id = @orders.last.id + 1 unless @orders.empty?
  end

  def save_csv
    # Open the file
    CSV.open(@csv_file_path, 'wb') do |csv|
      # Add the header
      csv << ["id", "delivered", "meal_id", "customer_id", "employee_id"]
      # Iterate over @orders array
      @orders.each do |order|
        # save each element into the row
        csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end
end
