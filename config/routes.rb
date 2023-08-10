Rails.application.routes.draw do
  get 'topics/show'
  get 'users/show'
  ## GET /about page:
  get "about-us", to: "about#index", as: :about

  ## GET root homepage page:
  root to: "pages#home"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  ## Quotes – routes for all of the standard CRUD actions and users can see the quotes they've added:
  resources :quotes do
    collection do
      get :user_quotes
      get :user_favorites
    end

    member do
      ## Routes for favoriting and unfavoriting:
      post 'add_favorite'
      delete 'remove_favorite'

      ## Routes for adding and removing topics:
      post :add_topic
      delete :remove_topic
    end
  end  

  ## Route to a user's profile and settings:
  resources :users, only: [:show, :update] do
    get 'settings', on: :collection
  end

  ## Routes for topics:
  resources :topics, only: [:show, :index]
  
  # Defines the root path route ("/")
  # root "articles#index"
end
