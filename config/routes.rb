Rails.application.routes.draw do
  #get 'users/new'
  resources :users
  
  resources :sessions,    only: [:new, :create, :destroy]
  
  resources :microposts,  only: [:new, :create, :destroy]
  
  resources :tables
    
  resources :seats

  resources :bookings
  
  resources :comments

  #get 'static_pages/home'
  #match '/home',    to: 'static_pages#home',    via: 'get'
  root to: 'static_pages#home'
  
  match '/signup',  to: 'users#new',            via: 'get'
  
  
  match '/signin',  to: 'sessions#new',         via: 'get'
  
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  
  
  
  #get 'static_pages/help'
  match '/help',    to: 'static_pages#help',    via: 'get'
  
  #get 'static_pages/about'
  match '/about',   to: 'static_pages#about',   via: 'get'
  
  #get 'static_pages/contact'
  match '/contact', to: 'static_pages#contact', via: 'get'
  
  
  match '/bookings/:id/book', to: 'bookings#book',   via: 'patch'
  
  match '/bookings/:id/unbook_totable', to: 'bookings#unbook_totable',   via: 'patch'
  
  match '/bookings/:id/unbook_toprofile', to: 'bookings#unbook_toprofile',   via: 'patch'
  
  match '/bookings',    to: 'bookings#check', via: 'patch'
  
  match '/checks',      to: 'bookings#show', via: 'post'
  
  
  match '/comment/:id/new', to: 'comments#new',  via: 'get'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
