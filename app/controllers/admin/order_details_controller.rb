class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = Order.find_by(id: @order_detail.order_id)
    @order_details = @order.order_details.all

    is_updated = true
    if @order_detail.update(order_detail_params)
      if @order_detail.status == "製作中"
        @order.update(status: 2)
      end
      @order_details.each do |order_detail|
        if order_detail.status != "製作完了"
          is_updated = false
        end
      end
      if is_updated == true
        @order.update(status: 3)
      end
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:status)
  end
end