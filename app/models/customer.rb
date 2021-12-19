class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

validates :last_name, 
length: { minimum: 1,maximum: 20 }

validates :first_name,
length: { minimum: 1,maximum: 20 }

validates :last_name_kana,
length: { minimum: 1,maximum: 20 }

validates :first_name_kana,
length: { minimum: 1,maximum: 20 }

validates :postal_code, presence: true

validates :address, presence: true

validates :telephone_number,
length: { minimum: 1,maximum: 11 }


  def active_for_authentication?
    super && (is_deleted == false)
  end

  def full_name
    last_name + first_name
  end

  devise :database_authenticatable, :registerable,
  :rememberable, :validatable

  has_many :items
  has_many :cart_items
  has_many :addresses
  has_many :orders
end
