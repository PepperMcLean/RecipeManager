class Recipe < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :users, through: :reviews
  validates :title, presence: true, length: {minimum: 4}
  validates :description, :ingredient_list, :instructions, presence: true, length: {minimum: 25}
  validates :required_appliances, presence: true, length: {minimum: 3}
end
