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
  end
end
