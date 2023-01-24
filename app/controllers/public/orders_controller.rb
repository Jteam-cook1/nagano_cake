class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items.each do |cart|
        order_detail = OrderDetail.new
        order_detail.item_id = cart.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart.amount
        order_detail.total_price = cart.item.price
        order_detail.save
      end
      redirect_to orders_complete_path
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def confirm
    @order = Order.new(order_params)
    @sub_total = 0
    @cart_item_total_price = 0
    @order.shipping_fee = 800
    @order.payment_method = params[:order][:payment_method]


    if params[:order][:address_number] == "1"

      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name

    elsif params[:order][:address_number] == "2"

      @shopping_address = ShoppingAddress.find(params[:order][:registered])
      @order.postcode = @shopping_address.postcode
      @order.address = @shopping_address.address
      @order.name = @shopping_address.name

    elsif params[:order][:address_number] == "3"

    end
    @cart_items_total_price = 0
  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details
    @sub_total = 0
    @total_price = 0
    @total = 0
    @order.shipping_fee = 800
     @order_details.each do |order_detail|
       @total = @total += order_detail.subtotal
       @total_price += order_detail.subtotal
     end


  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postcode, :address, :name, :total_price)
  end

  def address_params
    params.require(:order).permit(:name, :address)
  end
end
