Rails.application.routes.draw do  
  
  root "pages#index"
  get "/about", to: "pages#about"
  get "/pricing", to: "pages#pricing"
  get "/payment", to: "pages#payment"
  post "/checkout", to: "pages#payment"


  resources :favorites, only: [:index] 

  resources :boards do 
    member do
      post :favorite
      put :hide
    end

    resources :posts, shallow: true do
      resources :comments, shallow: true, only: [:create]
    end
  end

    # resources :posts, except: [:index, :new, :create]

  resources :users, only: [:create] do
    collection do
      get :sign_up
      get :edit
      patch :update
      get :sign_in
      post :login
      delete :sign_out
    end
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

end

