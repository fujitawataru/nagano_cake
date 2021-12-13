class Item < ApplicationRecord

  attachment :image

  has_many :cart_items
  has_many :order_detail

  def with_tax_price
  (price * 1.1 ).floor
  end

end
