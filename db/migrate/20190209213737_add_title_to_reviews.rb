class AddTitleToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :title, :string, null: false
  end
end
