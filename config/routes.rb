Rails.application.routes.draw do
  resources :receipts
  resources :locations

  resources :messages

  resources :histories

  resources :topics

  resources :accounts
end
