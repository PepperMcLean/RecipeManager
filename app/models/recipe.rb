class Recipe < ApplicationRecord
  belongs_to :user
  has_many :users, through :reviews
end
