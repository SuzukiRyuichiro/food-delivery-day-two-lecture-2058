require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    load_csv if File.exist?(@csv_file_path)
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
