class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  enum making_status: { impossible: 0,
                 waiting: 1,
                 producting: 2,
                 complete: 3 }
  
  
  def with_tax_price
  (price * 1.1 ).floor
  end
  
  def subtotal
    with_tax_price * amount 
  end

end
