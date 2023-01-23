class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer
  has_one_attached :image
  #belongs_to :order

  def subtotal
    item.with_tax_price * amount
  end
end
