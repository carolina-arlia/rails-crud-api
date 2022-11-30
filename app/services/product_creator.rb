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
    product = Product.create!(title: @title, description: @description, price: @price)
    product
  end

end
