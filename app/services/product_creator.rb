class ProductCreator < ApplicationService

  def initialize(attributes = {})
    @title = attributes[:title]
    @description = attributes[:description]
    @price = attributes[:price]
  end

  def call
    create_product
  end

  private

  def create_product
    product = Product.new(title: @title, description: @description, price: @price)
    product.save
    product
  end

end
