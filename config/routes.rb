Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  
  post 'projects/create', :to => 'projects#create'
  post 'projects/list', :to => 'projects#list'
  post 'images/upload', :to => 'images#upload'
  post 'images/list', :to => 'images#list'

  root to: "static#home"
  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"

end
