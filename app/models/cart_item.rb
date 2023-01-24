class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer
  validates :amount, presence: true
  #belongs_to :order

  def subtotal
    item.with_tax_price * amount
  end
end
