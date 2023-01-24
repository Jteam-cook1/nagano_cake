class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @orders = .find(params[:id])
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

  def update
  end
end