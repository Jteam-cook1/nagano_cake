class Public::CartItemsController < ApplicationController
  
  before_action :authenticate_customer!
  
  def index
    @cart_items = current_customer.cart_items
    @cart_item_total_price = 0
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
       cart_item = current_public.cart_items.find_by(item_id: params[:cart_item][:item_id])
       cart_item.amount += params[:cart_item][:amount].to_i
       cart_item.save
       redirect_to cart_items_path
    elsif @cart_item.save
       redirect_to cart_items_path
    else
       redirect_to cart_items_path
    end
  end

private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
