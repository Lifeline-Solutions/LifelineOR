class CartItem < ApplicationRecord
  # associations
  belongs_to :product
  belongs_to :cart

  # validations
  validates :product_id, uniqueness: { scope: :cart_id, message: 'can only be added once per cart' }

  # instance methods
  def increment_quantity
    self.quantity += 1
    save
  end

  def decrement_quantity
    self.quantity -= 1
    save
  end

  def total
    product.price * quantity
  end
end
