Rails.application.routes.draw do
  root 'home#index'
  resources :bulletins
  resources :users
  resource :session
  get 'signup' => 'users#new'
  get "signin" => "sessions#new"

  resources :users do
    member do
      get :confirm_email
    end
  end
  
end
