Rails.application.routes.draw do
  ## GET /about page:
  get "about-us", to: "about#index", as: :about

  ## GET root homepage page:
  root to: "pages#home"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  ## Quotes – routes for all of the standard CRUD actions:
  resources :quotes

  # Defines the root path route ("/")
  # root "articles#index"
end
