class CreateUserReviewVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :user_review_votes do |t|
      t.integer :user_id, null: false
      t.integer :review_id, null: false
      t.integer :user_votes, default: 0
      t.timestamps
    end
  end
end
