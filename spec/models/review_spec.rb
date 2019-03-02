require 'rails_helper'

RSpec.describe Review, type: :model do
  it "#initialize" do
    review = FactoryBot.create(:review)
    expect(review.user_rating).to be < 11
    expect(review.user_rating).to be >= 0
    expect(review.title).to_not be_nil
  end
end
