class AddVotesCountToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :votes_count, :integer
  end
end
