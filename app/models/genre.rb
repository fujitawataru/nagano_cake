class Genre < ApplicationRecord
  
  validates :name,
  length: { minimum: 1, maximum: 15 }
  
  has_many :items
end
