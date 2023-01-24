class Item < ApplicationRecord
  has_many :order_details
  has_many :cart_items
  belongs_to :genre
  has_one_attached :image
  validates :name, presence: true
  validates :description, presence: true
  validates :genre_id, presence: true
  validates :price, presence: true

  def add_tax_price
        (self.price * 1.10).round
  end

  def self.search(keyword)
    where(["name like?", "%#{keyword}%"])
  end

  def with_tax_price
    (price * 1.1).floor
  end
end
