require_relative '../views/session_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionView.new
  end

  def login
    # ask and get the username
    username = @sessions_view.ask_for('username')
    # ask and get the password
    password = @sessions_view.ask_for('password')
    # find the user (employee) with the given username
    employee = @employee_repository.find_by_username(username)
    # check if employee was found and the given password matches
    if employee && password == employee.password
      # if it matches continue with the app
      @sessions_view.logged_in
    else
      # if it doesn't, display that you got it wrong
      @sessions_view.wrong_credentials
      # and then repeat from the top
      login
    end
  end
end
