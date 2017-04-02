class Product < ApplicationRecord

  validates :name, :category, presence: true
  validates :price, :sale_price, presence: true, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: :sale_price }, if: -> { self.sale_price.present? }
end
