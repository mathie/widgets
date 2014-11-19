Rails.application.routes.draw do
  resources :widgets, only: [:index]
  root to: 'pages#index'
end
