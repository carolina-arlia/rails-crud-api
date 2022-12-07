class ProductUpdater < ApplicationService

  def initialize(params_for_update)
    @params_for_update = params_for_update
  end

  def call
    update_product
  end

  private

  def update_product
    product = Product.find_by_id(@params_for_update[:id])
    if product
      product.update(@params_for_update)
    end
    product
  end

end
