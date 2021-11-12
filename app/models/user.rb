class User < ApplicationRecord
  has_many :recipes
  has_many :reviews
  has_many :reviewed_recipes, through: :reviews, source: :recipe
  
  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates :display_name, presence: true, length: {minimum: 4}

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize do |user|
      user.display_name = auth.info.name
      user.email = auth.info.email
      user.password = SecureRandom.hex
    end
  end
end
