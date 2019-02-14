class RequireReviewUserRating < ActiveRecord::Migration[5.2]
  def change
    change_column :reviews, :user_rating, :integer, null: false
  end
end
