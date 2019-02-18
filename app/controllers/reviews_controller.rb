class ReviewsController < ApplicationController
  before_action :authorize_member_user, except: [:show,:index,:top_reviews]

  def index
    @reviews = Review.all
    if !current_user.nil?
      @user_reviews = Review.where(user: current_user)
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params.merge(user: current_user))
    binding.pry
    if @review.save
      flash[:notice] = "Review saved successfully"
    else
      flash[:notice] = @review.errors.full_messages.join(', ')
    end
    redirect_to root_path
  end

  def user_reviews
    @user_reviews = Review.where(user: current_user)
  end

  def user_index
    @user_reviews = Review.where(user_id: params[:user_id])
  end

  def top_reviews
    @top_reviews = Review.where("user_rating > ?", 8)
  end

  def search
    @search_results = Review.where("lower(title) LIKE ?", "%#{params[:q].downcase}%").all
  end

  def destroy
  end

private

  def review_params
    params.require(:review).permit(:review_photo,:title,:body,:user_rating)
  end

  def authorize_member_user
    if !user_signed_in?
      flash[:alert] = "You do not have access to this page"
      redirect_to root_path
    end
  end

  def authorize_admin_user
    if !current_user.admin?
      flash[:alert] = "You do not have access to this page"
      redirect_to root_path
    end
  end
end
