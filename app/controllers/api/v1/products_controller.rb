class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  # before_action :validate_params, only: [:update]

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
    render json: @product, status: :ok
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @product
      @product.destroy
    else
      render json: { error: 'Unable to delete Product' }, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  # def validate_params
  #   if !params.include?("title")
  #     render json: "error!!!", status: :unprocessable_entity
  #   end
  # end

end
