class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.page(params[:page]).reverse_order
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    #紐づく注文ステータスが「入金確認」になったら自動更新
    if @order.status == "paid_up"
       @order.order_details.update_all(making_status: "waiting")
    end
    #if @order.status = "paid_up"
       #@order.order_details.each do |order_detail|
       #order_detail.making_status = 1
    #end
    #end
    redirect_to admin_orders_path(@order.id)
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end

end
