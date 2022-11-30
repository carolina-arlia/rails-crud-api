require "rails_helper"

RSpec.describe ProductCreator do

  context "given a new product" do
    # product = Product.new(title: "zapato", description: "zapato viejo", price: 2.2)
    service = ProductCreator.call(title: "zapato", description: "zapato viejo", price: 2.2)

    it "return the product" do
      result = service
      expect(result.title).to eq("zapato")
      expect(result.description).to eq("zapato viejo")
      expect(result.price).to eq(2.2)
    end
  end
end
