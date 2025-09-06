Rails.application.routes.draw do
 root "users#index"

 # Users 
  get "/users/index", to: "users#index", as: "users"
  get "/users/:id", to: "users#show", as: "user"
  get "/users/new", to: "users#new", as: "new_user"
  get "/users/:id/edit", to: "users#edit", as: "edit_user"
 
  
end
