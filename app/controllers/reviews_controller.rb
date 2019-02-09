class ReviewsController < ApplicationController
  before_action :authorize_user, except: [:index,:show]

  def index
    @reviews = Review.all
    if current_user
      @user_reviews = Review.where(user: current_user)
    end
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

  def authorize_user
    if !user_signed_in? || !current_user.admin?
      flash[:alert] = "You do not have access to this page"
      redirect_to root_path
    end
  end
end
