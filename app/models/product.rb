class Product < ApplicationRecord
  validates :title, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false
  validates :price, presence: true, allow_blank: false
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
