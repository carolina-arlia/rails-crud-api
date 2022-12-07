require "rails_helper"

RSpec.describe ProductUpdater do

  context "given an id and new params" do
    product = Product.create(title: "Testing Updater Service", description: "Testing updater service by creating doing an unit test", price: 10.0)

    params_for_update = {
        id: product.id,
        title: "This updated title is working",
        description: "This updated description is also working",
        price: 23.0
      }

    product_updated = ProductUpdater.call(params_for_update)

    it "return an updated product" do
      expect(product_updated.title).to eq("This updated title is working")
      expect(product_updated.description).to eq("This updated description is also working")
      expect(product_updated.price).to eq(23.0)
    end
  end
end
