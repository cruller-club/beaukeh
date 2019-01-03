Rails.application.routes.draw do
  get "about", to: "static#about", as: :about
  get "gimme", to: "static#gimme", as: :gimme
  root to: "static#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
