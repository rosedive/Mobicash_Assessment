class Product < ApplicationRecord
  belongs_to :user
  
  validates :sku, :upc, :pname, :description, presence: true
end
