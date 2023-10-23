class User < ApplicationRecord
  devise :two_factor_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable

  # After User is create create a bio
  after_create :create_bio
  def create_bio
    Bio.create(user_id: id)
  end
  has_one :bio
  has_many :consultations
end
