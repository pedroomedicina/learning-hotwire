Rails.application.routes.draw do
  resources :projects do
    scope module: :projects do
      resources :memberships
      resources :todos do
        member do
          patch :reposition
        end
      end
      resources :users
      resource :name
    end
  end
  resources :todos

  # Authentication
  resource :session
  resources :passwords, param: :token
  resource :profile

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "projects#index"
end
