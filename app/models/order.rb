class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  belongs_to :customer
  has_many :order_details
  #入金待ち:0、入金確認:1、製作中:2、発送準備:３、発送済:４
  enum status: { waiting: 0,
                 paid_up: 1,
                 producting: 2,
                 shipping: 3,
                 shipped: 4 }
  
end
