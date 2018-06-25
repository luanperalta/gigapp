Rails.application.routes.draw do
  resources :products, except: [:show]
  resources :suppliers
  resources :orders
  resources :carriers, except: [:show]
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end