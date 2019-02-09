class AddVotesAndUserIdToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :user_rating, :integer
    add_column :reviews, :user_id, :integer, null: false
  end
end
