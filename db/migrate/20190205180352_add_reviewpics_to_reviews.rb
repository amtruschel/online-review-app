class AddReviewpicsToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :review_photo, :string
  end
end
