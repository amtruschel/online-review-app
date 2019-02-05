class Review < ApplicationRecord
  mount_uploader :review_photo, ReviewpicsUploader
end
