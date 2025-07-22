class Employee
  def initialize(attributes = {})
    @id = attributes[:id]
    @username = attributes[:username]
    @role = attributes[:role]
    @password = attributes[:password]
  end
end
