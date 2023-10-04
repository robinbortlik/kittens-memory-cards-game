Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :games, only: [:index, :show, :new] do
    member do
      get :reset
    end
    resources :cards, only: [:show]
  end
  root "games#index"
end
