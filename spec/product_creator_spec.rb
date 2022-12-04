require "rails_helper"

RSpec.describe ProductCreator do

  context "given a new product" do
    product = ProductCreator.call(title: "zapato", description: "zapato viejo", price: 2.2)

    it "return the product" do
      expect(product.title).to eq("zapato")
      expect(product.description).to eq("zapato viejo")
      expect(product.price).to eq(2.2)
      expect(product.id).not_to be_nil
    end
  end
end
