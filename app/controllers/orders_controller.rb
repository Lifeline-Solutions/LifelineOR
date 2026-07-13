class OrdersController < ApplicationController

  def checkout
    @order = Order.create_or_find_by(
      cart: current_user.cart
    )
  end
end