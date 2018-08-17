# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroying old files..."
Cocktail.destroy_all
Dose.destroy_all
Ingredient.destroy_all

puts "Filling up database"

require 'open-uri'

(0..10).each do
  doc = open('https://www.thecocktaildb.com/api/json/v1/1/random.php').read
  doc = JSON.parse(doc)['drinks'][0]
  drink = doc["strDrink"].downcase
  coc = Cocktail.create(name: drink)
  ingredients = []
  doses = []
  (1..15).each do |index|
    return false if doc["strIngredient#{index}"].nil?
    if doc["strIngredient#{index}"].match(/\w/)
      ingredients << doc["strIngredient#{index}"]
      doses << doc["strMeasure#{index}"]
    end
  end
  ingredients.each_with_index do |ingredient, index|
    ing = Ingredient.create(name: ingredient.downcase)
    ing = Ingredient.find_by(name: ingredient.downcase) unless ing
    dose = Dose.new(description: doses[index].downcase)
    dose.cocktail = coc
    dose.ingredient = ing
    dose.save
  end
end

# ingredients = open('https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list').read
# ingredients = JSON.parse(ingredients)["drinks"]

# (0...3).each do |index|
#   ingredient_name = ingredients[index]["strIngredient1"].downcase
#   Ingredient.create(name: ingredient_name)
#   drinks = open("https://www.thecocktaildb.com/api/json/v1/1/search.php?i=#{ingredient_name}").read
#   drinks = JSON.parse(drinks)["drinks"]
#   (0...5).each do |i|
#     drink_name = drink[i]["strDrink"].downcase
#     Cocktail.create(name: drink_name)
#   end

# end

puts "Finished!"
