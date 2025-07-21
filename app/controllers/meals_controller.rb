require_relative "../views/meal_view"

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meal_view = MealView.new
  end

  def list
    # get all the meals from the repository
    meals = @meal_repository.all
    # send them to the view to display
    @meal_view.display(meals)
  end

  def add
    # Ask the view to ask the user for a name and store it
    name = @meal_view.ask_for("name")
    # Ask the view to ask the user for a price
    price = @meal_view.ask_for("price").to_i
    # Make a new meal instance with the user info
    meal = Meal.new(name: name, price: price)
    # Ask the repository to store the meal
    @meal_repository.create(meal)
  end
end
