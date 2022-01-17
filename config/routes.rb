Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'static#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  get 'static/about', to: 'static#about', as: :about
  get '/', to: 'static#index', as: :index
  post '/', to: 'static#gimme', as: :gimme
end
