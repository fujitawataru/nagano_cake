class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

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
