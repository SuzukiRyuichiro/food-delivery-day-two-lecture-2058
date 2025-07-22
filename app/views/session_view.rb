class SessionView
  def ask_for(thing)
    puts "What's the #{thing}?"
    gets.chomp
  end

  def wrong_credentials
    puts "Hey wrong password or user was not found"
  end

  def logged_in
    puts "Logged in!"
  end
end
