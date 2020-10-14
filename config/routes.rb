Rails.application.routes.draw do
  root 'home#index'
  resources :bulletins
  resources :users
  get 'signup' => 'users#new'
end
