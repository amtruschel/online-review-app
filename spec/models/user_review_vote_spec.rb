require 'rails_helper'

RSpec.describe UserReviewVote, type: :model do
  it "#initialize" do
    user_review_vote = FactoryBot.create(:user_review_vote)
    expect(user_review_vote.user_votes).to eq(1)
    expect(user_review_vote.user).to_not be_nil
    expect(user_review_vote.review).to_not be_nil
  end
end
