class Review < ApplicationRecord
  attr_accessor :review_photo
  belongs_to :user
  mount_uploader :review_photo, ReviewpicsUploader

  validates :user_rating, presence: true
  validates :user_rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :user_id, presence: true
  validates :title, presence: true
end
