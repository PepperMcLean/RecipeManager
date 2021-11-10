class User < ApplicationRecord
  has_many :recipes
  has_many :reviews
  has_many :reviewed_recipes, through: :reviews, source: :recipe
  
  has_secure_password
  validates :email, uniqueness: true
  validates :display_name, uniqueness: true, length: {minimum: 4}
end
