Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:index] do
    resources :reviews, only: [:index], action: "user_index", as: "reviews"
  end

  resources :reviews, except: [:index] do
    post "up_vote", to: "reviews#up_vote"
    post "down_vote", to: "reviews#down_vote"
  end

  get "all_reviews", to: "reviews#all_reviews"
  get "top_reviews", to: "reviews#top_reviews"
  get "reviews_search", to: "reviews#search"

  root to: "reviews#index"
end
