class Review < ApplicationRecord
  mount_uploader :review_photo, ReviewpicsUploader
  belongs_to :user
  validates :user_rating, presence: true
  validates :user_rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :user_id, presence: true
  validates :body, presence: true
  validates :title, presence: true
end
