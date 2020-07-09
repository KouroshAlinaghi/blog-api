Rails.application.routes.draw do

  resources 'posts', only: [:index, :show, :create, :destroy, :update]

  post   'login',  to: "sessions#create"
  delete 'logout', to: "sessions#destroy"

  post   'sign_up',   to: "authors#create"
  put    'dashboard', to: "authors#update"
  get    'dashboard', to: "authors#dashboard"
  delete 'dashboard', to: "authors#destroy"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
