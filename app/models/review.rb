class Review < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  validates :title, :content, presence: true, length: {minimum: 4}
  validates_inclusion_of :rating, :in => 1..5, message: "is between 1-5"
end
