# frozen_string_literal: true

namespace :api do
    namespace :v1 do
      scope :users, module: :users do
        post '/', to: 'registrations#create', as: :user_registration
      end
      resources :earthquakes, only: [:index, :show, :create, :update, :destroy]
    end
  end
  
  # Doorkeeper integration
  scope :api do
    scope :v1 do
      use_doorkeeper do
        skip_controllers :authorizations, :applications, :authorized_applications
      end
    end
  end
  