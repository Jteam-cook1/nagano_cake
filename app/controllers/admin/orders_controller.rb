class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total_price = 0
    @total = 0
    @order.shipping_fee = 800
    @order_details.each do |order_detail|
      @total += order_detail.subtotal
    end
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
    if @order.update(order_params)
      if @order.status == "入金確認"
        @order_details.update_all(status: 1)
      end
    end
    redirect_to admin_order_path(@order)
  end

  private
    def order_params
      params.require(:order).permit(:status)
    end
end
