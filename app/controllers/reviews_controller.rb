class ReviewsController < ApplicationController
  before_action :authorize_member_user, except: [:show,:index,:top_reviews,:search]
  before_action :get_review, only: [:show,:edit,:update,:up_vote,:down_vote,:destroy]

  def index
    @recent_reviews = Review.all.order('created_at DESC').limit(10)
    if !current_user.nil?
      @user_reviews = Review.where(user: current_user).order('created_at DESC').limit(10)
    end
  end

  def show
  end

  def new
    @review = Review.new
  end

  def edit
  end

  def update
    @review.update(review_params)
    if @review.save
      flash[:notice] = "Review updated successfully"
      redirect_to review_path(@review)
    else
      flash[:notice] = @review.errors.full_messages.join(', ')
      render "edit"
    end
  end

  def create
    @review = Review.new(review_params.merge(user: current_user))
    if @review.save
      flash[:notice] = "Review saved successfully"
      redirect_to review_path(@review)
    else
      flash[:notice] = @review.errors.full_messages.join(', ')
      render "new"
    end
  end

  def user_reviews
    @user_reviews = Review.where(user: current_user)
  end

  def user_index
    @user_reviews = Review.where(user_id: params[:user_id]).order('created_at DESC')
  end

  def top_reviews
    @top_reviews = Review.where("user_rating > ?", 8)
  end

  def all_reviews
    @all_reviews = Review.all.order('created_at DESC')
  end

  def search
    @search_results = Review.where("lower(title) LIKE ?", "%#{params[:q].downcase}%").all
  end

  def up_vote
    @review.votes_count += 1
    if @review.save
      flash.now[:alert] = "Thanks for voting"
      render "show"
    end
  end

  def down_vote
    @review.votes_count -= 1
    if @review.save
      flash.now[:alert] = "Thanks for voting"
      render "show"
    end
  end

  def destroy
    @review.destroy!
    flash[:alert] = "Your question has been deleted"
    redirect_to root_path
  end

private

  def review_params
    params.require(:review).permit(:review_photo,:title,:body,:user_rating)
  end

  def get_review
    @review = Review.find(params[:id])
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
