class Employee
  attr_reader :role, :id, :username, :password

  def initialize(attributes = {})
    @id = attributes[:id]
    @username = attributes[:username]
    @role = attributes[:role]
    @password = attributes[:password]
  end

  def rider?
    @role == 'rider'
  end

  def manager?
    @role == 'manager'
  end
end
