FactoryBot.define do
  factory :user_review_vote do
    user_votes { 1 }
    
    user
    review
  end
end
