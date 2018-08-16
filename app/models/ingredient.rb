class Ingredient < ApplicationRecord
  has_many :doses
  before_destroy :check_doses

  validates :name, presence: true, allow_blank: false, uniqueness: true
  validates_associated :doses

  private

  def check_doses
    if doses.count.positive?
      raise ActiveRecord::InvalidForeignKey
      # raise "InvalidForeignKey"
      # errors.add('cannot delete an ingredient that is used in a cocktail')
      false
    end
  end
end
