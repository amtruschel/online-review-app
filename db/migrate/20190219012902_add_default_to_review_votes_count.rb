class AddDefaultToReviewVotesCount < ActiveRecord::Migration[5.2]
  def change
    change_column :reviews,:votes_count,:integer, default: 0
  end
end
