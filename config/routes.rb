Rails.application.routes.draw do
  devise_for :users

  # Root route - CategoriesController will handle authentication via before_action
  root "categories#new"

  # Categories with nested entries
  resources :categories, except: [:index] do
    resources :entries, except: [:index]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by uptime monitors and load balancers.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
