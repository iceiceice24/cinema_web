Rails.application.routes.draw do
  namespace :admin do
    root 'admin/cinemas#new'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    resources :screenings, only: [:new, :create]
    delete 'logout', to: 'sessions#destroy'
    resources :cinemas, only: [:new, :create]
    resources :movies, only: [:new, :create]
  end

  
  resources :users
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  
  resources :screenings, only: [:index, :show] do
    member do 
      get 'bookings/new'
    end
    resources :bookings, only: [:create]
  end
end
