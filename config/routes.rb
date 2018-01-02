Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "games#index"
  resources :games

  get "/login", to: "sessions#new", as: "signin"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"

end
