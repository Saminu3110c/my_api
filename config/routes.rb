Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  post "/graphql", to: "graphql#execute"
  get "home/index"
  use_doorkeeper
  devise_for :users
  get "earthquakes/index"
  get "earthquakes/show"
  get "earthquakes/create"
  get "earthquakes/update"
  get "earthquakes/destroy"

  # resources :earthquakes, only: [:index, :show, :create, :update, :destroy]
  
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "home#index"

end
