Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  get '', to: 'home#index'
  get 'idiom', to: 'fields#idiom'
  resources :publications
  resources :data_users
  resources :fields
end
