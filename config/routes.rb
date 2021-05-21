Rails.application.routes.draw do
  
  resources :adjustments
  devise_for :users
  root "loans#index"
  resources :loans
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
