class Order < ApplicationRecord
    belongs_to :customer
    has_many :order_details
    has_one_attached :image

    validates :postcode, presence: true
    validates :address, presence: true
    validates :name, presence: true

    enum payment_method: { "クレジットカード": 0, "銀行振込": 1 }
    enum status:{ "入金待ち":0, "入金確認":1, "製作中":2, "発送準備中":3, "発送済み":4 }

    def subtotal
    item.with_tax_price * amount
    end

end
