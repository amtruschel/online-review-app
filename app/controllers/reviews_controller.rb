class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params.merge(user: current_user))
  end

  def user_reviews
    @user_reviews = Review.where(user: current_user)
  end

private

  def configure_review_params
    params.require(:review).permit(:review_photo)
  end
end
