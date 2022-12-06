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

  describe 'GET /api/v1/products' do
    context 'asking for list of products' do
      it 'returns a list' do
        get api_v1_products_url
        products = Product.all
        product_list_response = JSON.parse(response.body, object_class: Product)
        expect(product_list_response.size).to eq(products.size)
      end

      it 'returns a 200 http response' do
        get api_v1_products_url
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /api/v1/products/:id' do
    context 'asking for a product' do

      product = Product.new(title: "testing product Caro", description: "testing description product Caro", price: 83.0)
      product.save

      it 'returns the product' do
        get api_v1_product_url(product.id)
        product_response = JSON.parse(response.body, object_class: Product)
        expect(product_response.id).to eq(product.id)
        expect(product_response.title).to eq(product.title)
        expect(product_response.description).to eq(product.description)
        expect(product_response.price).to eq(product.price)

      end

      it 'returns a 200 http response' do
        get api_v1_product_url(product.id)
        expect(response).to have_http_status(:ok)
      end
    end
  end

end
