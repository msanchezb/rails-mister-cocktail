# Cocktail class
class Cocktail < ApplicationRecord
  require 'open-uri'
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses

  validates :name, presence: true, allow_blank: false, uniqueness: true
  validates_associated :doses

  def instructions
    info['strInstructions']
  end

  def picture
    info['strDrinkThumb']
  end

  private

  def info
    doc = open("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{name}").read
    doc = JSON.parse(doc)['drinks'][0]
  end
end
