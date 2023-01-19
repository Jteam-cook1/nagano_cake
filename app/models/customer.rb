class Customer < ApplicationRecord
  has_many :cart_items
  has_many :shopping_addresses
  has_many :orders
  #has_many :addresses
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  class User < ApplicationRecord
  # is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_active == false)
  end
  end

end
