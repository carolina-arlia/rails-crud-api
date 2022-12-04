# require "rails_helper"

# RSpec.describe ProductsController, type: :request do
#   describe 'POST /create' do
#     context "with valid parameters" do
#       it "creates a product" do
#         params = {
#           product: {
#             title: "testing product Caro",
#             description: "testing description product Caro",
#             price: 83.0
#           }
#         }

#         expect do
#           post "/products", params: params
#         end.to change(Product, :count).by(1)

#         expect(response).to have_http_status(:created)

#       end
#     end
#   end
# end
