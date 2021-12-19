class Item < ApplicationRecord
  
  validates :name,
  length: { minimum: 1, maximum: 20 }
  
  validates :introduction,
  length: { minimum: 1, maximum: 50 }
  
  validates :price, presence: true
  
  validates :is_active, inclusion: { in: [true, false] }

  attachment :image

  has_many :cart_items
  has_many :order_detail
  belongs_to :genre

  def with_tax_price
  (price * 1.1 ).floor
  end

end
