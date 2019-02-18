class UpdateRequiredColumnsOnReviews < ActiveRecord::Migration[5.2]
  def change
    change_column_null :reviews, :body, from: false, to: true
  end
end
