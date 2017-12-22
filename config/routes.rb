Rails.application.routes.draw do
  #get 'users/new'
  resources :users

  #get 'static_pages/home'
  #match '/home',    to: 'static_pages#home',    via: 'get'
  root to: 'static_pages#home'
  
  match '/signup',  to: 'users#new',            via: 'get'
  
  #get 'static_pages/help'
  match '/help',    to: 'static_pages#help',    via: 'get'
  
  #get 'static_pages/about'
  match '/about',   to: 'static_pages#about',   via: 'get'
  
  #get 'static_pages/contact'
  match '/contact', to: 'static_pages#contact', via: 'get'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
