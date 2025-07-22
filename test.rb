# require_relative 'app/models/employee'
require_relative 'app/repositories/employee_repository'

# youssef = Employee.new(id: 1, username: 'youssef', password: '123123', role: 'manager')
# p youssef


csv_file_path = File.join(__dir__, 'data/employees.csv')
employee_repository = EmployeeRepository.new(csv_file_path)

pp employee_repository
