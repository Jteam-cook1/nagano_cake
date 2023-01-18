class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @address = ShoppingAddress.find(params[:order][:address_id])
    @order.postcode = current_customer.postcode
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.order.new(order_params)
    if @order.save
      cart_items.each do |cart|
        order_item = OrderItem.new
        order_item.item_id = cart.item_id
        order_item.order_id = @order.id
        order_item.order_amount = cart.amount
        order_item.order_price = cart.item.price
        order_item.save
      end
      redirect_to orders_confirm_path
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def check
    @order = Order.new(order_params)
    if params[:order][:address_number] == "1"
      @order.name = current_customer.name
      @order.address = current_customer.customer_address
    elsif params[:order][:address_number] == "2"

      if Address.exists?(name: params[:order][:registered]).name
        @order.name = Address.find(params[:order][:registered]).address
      else
        render :new
      end
    elsif params[:order][:address_number] == "3"
      address_new = current_customer.addresses.new(address_params)
      if address_new.save
      else
        render :new
      end
    else
      redirect_to orders_confirm_path
    end
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
  end


  def complete
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postcode, :address, :name, :total_price)
  end

  def address_params
    params.require(:order).permit(:name, :address)
  end
end
