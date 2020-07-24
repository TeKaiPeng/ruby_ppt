Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  
  # root "pages#index"
  get "/about", to: "pages#about"
  resources :boards
  get "/edit", to: "boards#edit"

  # get "/boards", to: "pages#boards"
  # get "/", to: "pages#index"



end

