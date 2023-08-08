Rails.application.routes.draw do
  ## GET /about page:
  get "about", to: "about#index"

  ## GET root homepage page:
  root to: "main#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
