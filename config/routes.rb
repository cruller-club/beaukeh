Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'static#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  get 'about', to: 'static#about', as: :about
  
  get 'static', to: 'static#index', as: :index
  get 'static/:background_color', to: 'static#index', as: :background
  post 'static', to: 'static#gimme', as: :gimme
end
