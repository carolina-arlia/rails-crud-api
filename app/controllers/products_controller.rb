class ProductsController < ApplicationController

  def create
    ProductCreator.call(product_params)
  end

  def index
    Product.all
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end

end
