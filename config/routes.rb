Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'static#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  get 'about', to: 'static#about', as: :about
  
  get 'static', to: 'static#index', as: :index
  # get 'mint', to: 'static#mint', as: :mint
  get 'static/:background_color', to: 'static#index', as: :background
  get 'gimme/:signature', to: 'static#gimme', as: :gimme
  get 'show/:signature', to: 'static#show', as: :show
  get 'meta/:signature', to: 'static#meta', as: :meta
end
