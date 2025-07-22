class OrderView
  def ask_for_index
    puts "Type a number"
    gets.chomp.to_i - 1
  end

  def display(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1} - #{order.meal.name} to #{order.customer.name} by #{order.employee.username}"
    end
  end
end
