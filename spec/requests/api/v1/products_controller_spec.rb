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

  describe 'PUT /api/v1/products/:id' do
    context 'updating with valid parameters' do
      product = Product.new(title: "testing pre-update Caro", description: "testing description product pre-update", price: 83.0)
      product.save

      params = {
        product: {
          title: "title updated Caro",
          description: "description updated Caro",
          price: 23.0
        }
      }

      it 'returns the product with new values' do
        put api_v1_product_url(product.id), params: params
        product_updated = JSON.parse(response.body, object_class: Product)

        expect(product_updated.title).to eq("title updated Caro")
        expect(product_updated.description).to eq("description updated Caro")
        expect(product_updated.price).to eq(23.0)
      end

      it 'returns a 200 http response' do
        put api_v1_product_url(product.id), params: params

        expect(response.status).to eq(200)
      end
    end

    context 'updating with invalid parameters' do
      product = Product.new(title: "testing pre-update Caro", description: "testing description product pre-update", price: 83.0)
      product.save

      params = {
        product: {
          title: "",
          description: "",
          price: -1.0,
        }
      }

      it 'returns a list of errors' do
        put api_v1_product_url(product.id), params: params
        product_not_updated = JSON.parse(response.body)

        expect(product_not_updated["title"]).to eq(["can't be blank"])
        expect(product_not_updated["description"]).to eq(["can't be blank"])
        expect(product_not_updated["price"]).to eq(["must be greater than or equal to 0"])
      end

      it 'the product doesnt persist new values' do
        put api_v1_product_url(product.id), params: params

        expect(product.title).to eq("testing pre-update Caro")
        expect(product.description).to eq("testing description product pre-update")
        expect(product.price).to eq(83.0)
      end

      it 'response should have HTTP Status 422 Unprocessable entity' do
        put api_v1_product_url(product.id), params: params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /api/v1/products/:id' do
    context 'asking to delete a product by id' do
      product_to_delete = Product.create(title: "Product to delete Caro", description: "Testing description product to delete", price: 80.0)

      it 'returns a HTTP Status 204 No content ' do
        delete api_v1_product_url(product_to_delete.id)

        expect(response).to have_http_status(:no_content)
      end

      it 'should destroy a product' do
        expect do
          delete api_v1_product_url(product_to_delete.id)
        end.to change(Product, :count).by(-1)
      end
    end

    context 'asking to delete a nonexistent product' do
      it 'response should have HTTP Status 422 Unprocessable entity' do
        delete api_v1_product_url(00)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
