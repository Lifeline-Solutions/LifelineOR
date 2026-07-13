class CartItemsController < ApplicationController
  before_action :find_product
  before_action :set_cart_item, only: %i[increment decrement]

  def create
    @item = @cart.cart_items.new(product: @product, quantity: 1)

    respond_to do |format|
      if @item.save
        format.html { redirect_to products_path, notice: "#{@product.name} added to cart." }
      else
        format.html { redirect_to products_path, alert: 'Something went wrong, try again.' }
      end
    end
  end

  def increment
    respond_to do |format|
      if @cart_item.increment_quantity
        format.html { redirect_to products_path, notice: 'Quantity increased.' }
      else
        message = @cart_item.errors.full_messages.join(', ')
        format.html { redirect_to products_path, alert: message }
      end
    end
  end

  def decrement
    respond_to do |format|
      if @cart_item.quantity <= 1
        @cart_item.destroy
        format.html { redirect_to products_path, notice: 'Item removed from cart.' }
      elsif @cart_item.decrement_quantity
        format.html { redirect_to products_path, notice: 'Quantity decreased.' }
      else
        message = @cart_item.errors.full_messages.join(', ')
        format.html { redirect_to products_path, alert: message }
      end
    end
  end

  private

  def find_product
    @product = Product.find(params[:product_id])
  end

  def set_cart_item
    @cart_item = @cart_items.find_by(product_id: @product.id)
  end
end
