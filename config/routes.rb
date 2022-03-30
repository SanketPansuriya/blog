Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "articles#index"

  get "/articles", to: "articles#index"
  get "/application", to: "application#index1"
   get "/application/1", to: "application#a1"
  # Defines the root path route ("/")
  # root "articles#index"
  
  resources :users do
    resources :books
  end
end
