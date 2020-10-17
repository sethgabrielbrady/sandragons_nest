Rails.application.routes.draw do
  root 'home#index'
  resources :bulletins
  resources :users
  resource :session
  get 'signup' => 'users#new'
  get "signin" => "sessions#new"
end
