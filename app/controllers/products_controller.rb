class ProductsController < ApplicationController

  def create
    # product_creator = ProductCreator.new(product_params)
    # product_creator.create_product
    ProductCreator.call(product_params)
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end

end
