class User < ApplicationRecord
  devise :two_factor_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable

  # After User is create create a bio
  after_create :create_bio, :create_profile
  def create_bio
    Bio.create(user_id: id)
  end

  def create_profile
    Profile.create(user_id: id)
  end
  has_one :bio, foreign_key: :user_id, class_name: 'Bio', dependent: :destroy
  has_many :consultation, foreign_key: :user_id, class_name: 'Consultation', dependent: :destroy
  has_one :profile, foreign_key: :user_id, class_name: 'Profile', dependent: :destroy
end
