class User < ApplicationRecord
  devise :two_factor_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable

  # After User is create create a bio
  after_create :create_profile
  after_create :create_cart

  # associations
  has_one :cart

  def create_profile
    Profile.create(user_id: id)
  end

  def create_cart
    Cart.create!(user_id: id)
  end

  has_one :next, foreign_key: :user_id, class_name: 'Next', dependent: :destroy
  has_one :profile, foreign_key: :user_id, class_name: 'Profile', dependent: :destroy

  has_many :exist, foreign_key: :user_id, class_name: 'Exist', dependent: :destroy
  has_many :consultation, foreign_key: :user_id, class_name: 'Consultation', dependent: :destroy
  has_many :chats, foreign_key: :user_id, class_name: 'Chat', dependent: :destroy
end
