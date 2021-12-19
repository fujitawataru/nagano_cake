class Address < ApplicationRecord
  
  
validates :name, 
 length: { minimum: 1 }

validates :postal_code, presence: true

validates :address, presence: true

  
  belongs_to :customer
  
def full_address
    '〒' + postal_code + ' ' + address + ' ' + name
end
end