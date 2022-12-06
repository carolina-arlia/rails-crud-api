Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products
    end
  end

  # get 'products', to: 'products#index'
  # post 'products', to: 'products#create'
end
