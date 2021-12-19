class CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
   @cart_items = current_customer.cart_items 
   @total = 0
   @cart_items.each do |cart_item| 
   tal = cart_item.subtotal
   @total += tal
  end
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end
  
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    #追加した商品がカート内に存在した場合
  if cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
     cart_item.amount += params[:cart_item][:amount].to_i
     cart_item.save
     redirect_to cart_items_path
     #追加した商品がカート内に存在しなかった
  else @cart_item.save
      redirect_to cart_items_path
  end
  end
  
  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  def cart_item_params
    params.require(:cart_item).permit(:item_id,:amount)
  end
end
