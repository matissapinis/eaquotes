Rails.application.routes.draw do
  ## GET /about page:
  get "about-us", to: "about#index", as: :about

  ## GET root homepage page:
  root to: "main#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
