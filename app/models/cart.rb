class Cart < ApplicationRecord
  # associations
  belongs_to :user
  has_many :cart_items

  # validations
  validates :user_id, uniqueness: true
end
