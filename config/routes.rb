Rails.application.routes.draw do
  namespace :v1 do
    resources :receipts
    resources :locations
    resources :messages
    resources :histories
    resources :topics
    resources :accounts
  end
end
