require "rails_helper"

RSpec.describe "Products endpoints", type: :request do
  describe 'POST /api/v1/products' do
    context 'with valid parameters' do
      params = {
        product: {
          title: "testing product Caro",
          description: "testing description product Caro",
          price: 83.0
        }
      }

      it 'creates a product' do
        expect do
          post api_v1_products_url, params: params
        end.to change(Product, :count).by(1)
      end

      it 'returns a 201 http response' do
        post api_v1_products_url, params: params

        expect(response).to have_http_status(:created)
      end

      it 'persists the values given as params' do
        post api_v1_products_url, params: params

        product = Product.last
        expect(product.title).to eq("testing product Caro")
        expect(product.description).to eq("testing description product Caro")
        expect(product.price).to eq(83.0)
      end
    end

    context 'with invalid parameters' do
      params = {
        product: {
          description: "testing description product Caro",
          price: 83.0
        }
      }

      it 'returns a unprocessable entity status' do
        post api_v1_products_url, params: params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not persist the product' do
        post api_v1_products_url, params: params

        expect do
          post api_v1_products_url, params: params
        end.not_to change(Product, :count)
      end


    end
  end
end
