class Order
  attr_accessor :id
  attr_reader :employee, :customer, :meal

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @delivered = attributes[:delivered] || false # boolean
    @employee = attributes[:employee] # instance of Employee
    @customer = attributes[:customer] # instance of Customer
    @meal = attributes[:meal] # instance of Meal
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end
