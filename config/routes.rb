Rails.application.routes.draw do
  get "earthquakes/index"
  get "earthquakes/show"
  get "earthquakes/create"
  get "earthquakes/update"
  get "earthquakes/destroy"

  # resources :earthquakes, only: [:index, :show, :create, :update, :destroy]
  
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
