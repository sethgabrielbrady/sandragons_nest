Rails.application.routes.draw do
  resources :bulletins
  resources :users
  get 'signup' => 'users#new'
end
