class Api::V1::ProductsController < ApplicationController

  def create
    product = ProductCreator.call(product_params)

    if product.valid?
      render json: product, status: :created
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  def index
    products = Product.all
    render json: products, status: :ok
  end

  def show
    product = Product.find(params[:id])
    render json: product, status: :ok
  end

  def update
    product = Product.find(params[:id])
    if product
      product.update(product_params)
      render json: product, status: :ok
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end



  private

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end

end
