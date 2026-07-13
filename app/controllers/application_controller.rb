class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart, if: :current_user

  private

  def set_cart
    @cart = current_user.cart
    @cart_items = @cart.cart_items
    @cart_total = @cart_items.sum(&:total)
  end
end
