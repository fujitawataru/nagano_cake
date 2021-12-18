class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = Order.find(params[:order_id])#なぜ[:order_id]なのか
    if @order_detail.making_status  == "producting" 
      @order.update(status: "producting")
      redirect_to admin_order_path(@order.id)
    else @order.order_details.all? {|order_detail| order_detail.making_status } == "complete"
         @order.update(status: "shipping") 
         redirect_to admin_order_path(@order.id)
    end
  end
  #@order_detail = OrderDetail.find(params[:id])
  #@order = Order.find(params[:order_id]
  #s.all? {|order_detail| order_detail.making_status== "producting"
  
  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
  
end
