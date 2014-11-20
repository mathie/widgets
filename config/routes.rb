Rails.application.routes.draw do
  resources :widgets, only: [:index, :new, :create]
  root to: 'pages#index'
end
