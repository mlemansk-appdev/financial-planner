Rails.application.routes.draw do
  
  root "loans#index"
  resources :adjustments
  devise_for :users
  resources :loans
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
