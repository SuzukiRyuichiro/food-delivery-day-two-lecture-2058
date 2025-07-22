require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    load_csv if File.exist?(@csv_file_path)
  end

  def all_riders
    # Returns array of employee instances, who are all riders
    @employees.select { |employee| employee.role == 'rider' }
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end


  private

  def load_csv
    # Open and start iterating each row
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # Make an instance of employee from the row
      # Put the instance into the array
      row[:id] = row[:id].to_i
      @employees << Employee.new(row)
    end
  end
end
