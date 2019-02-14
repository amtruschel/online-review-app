FactoryBot.define do
  factory :review do
    body { "This is a sample review. This thing was amazing!" }
    user_rating { 6 }
    user
  end
end
