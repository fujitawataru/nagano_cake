class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items
    @total = 0
    @cart_items.each do |cart_item|
    tal = cart_item.subtotal
    @total += tal
    end
  
  
    @order = Order.new(order_params)
    #hidden_fieldで注文機能へ情報を送るためshipping_costとtotal_paymentの金額を定義
    @order.shipping_cost = 800
    @order.total_payment = @total + 800
    
    #newアクションで選択したお届け先によって条件分岐
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
    
  end

  def create
    
    order = Order.new(order_params) #確認画面から送られてきた情報を取得
    order.customer_id = current_customer.id
    order.status = 0
    order.save
    cart_items = current_customer.cart_items #42,43でカート内商品の情報をすべて取得し1つずつ格納
    cart_items.each do |cart_item|
    order_detail = OrderDetail.new
    order_detail.order_id = order.id
    order_detail.item_id = cart_item.item.id
    order_detail.price = cart_item.item.price
    order_detail.amount = cart_item.amount
    order_detail.making_status = 0
    order_detail.save
    current_customer.cart_items.destroy_all #カート内商品を全て削除
    redirect_to orders_complete_path
  end
  end
  


  private
  def order_params
    params.require(:order).permit(:payment_method,:postal_code, :address, :name,:total_payment,:shipping_cost)
  end
end
