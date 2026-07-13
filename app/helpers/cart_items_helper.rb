module CartItemsHelper
  def product_in_cart?(product)
    @cart_items.exists?(product_id: product.id)
  end

  def cart_item(product)
    @cart_items.find_by(product_id: product.id)
  end
end
