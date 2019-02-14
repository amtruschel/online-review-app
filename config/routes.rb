Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:index] do
    resources :reviews, only: [:index], action: "user_index", as: "reviews"
  end

  resources :reviews, except: [:index]

  get "top_reviews", to: "reviews#top_reviews"
  get "reviews_search", to: "reviews#search"

  root to: "reviews#index"
end
