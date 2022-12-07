class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :destroy]
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
    # if @product.update(product_params)
    #   render json: @product
    # else
    #   render json: @product.errors, status: :unprocessable_entity
    # end
    params_for_update = product_params
    params_for_update[:id] = params[:id]

    product_updated = ProductUpdater.call(params_for_update)

    if product_updated == nil
      render json: { error: 'Unable to update nonexistent Product' }, status: :unprocessable_entity
    elsif product_updated.valid?
      render json: product_updated
    else
      render json: product_updated.errors, status: :unprocessable_entity
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
    @product = Product.find_by_id(params[:id])
  end

  # def validate_params
  #   if !params.include?("title")
  #     render json: "error!!!", status: :unprocessable_entity
  #   end
  # end

end
