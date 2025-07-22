require_relative 'app/repositories/customer_repository'
require_relative 'app/repositories/meal_repository'
require_relative 'app/repositories/employee_repository'
require_relative 'app/repositories/order_repository'

customers_csv_file_path = File.join(__dir__, 'data/customers.csv')
customer_repository = CustomerRepository.new(customers_csv_file_path)

meals_csv_file_path = File.join(__dir__, 'data/meals.csv')
meal_repository = MealRepository.new(meals_csv_file_path)

employees_csv_file_path = File.join(__dir__, 'data/employees.csv')
employee_repository = EmployeeRepository.new(employees_csv_file_path)

orders_csv_file_path = File.join(__dir__, 'data/orders.csv')
order_repository = OrderRepository.new(orders_csv_file_path, meal_repository, customer_repository, employee_repository)

pp order_repository
