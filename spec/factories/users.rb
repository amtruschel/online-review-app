FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "test#{n}@gmail.com"}
    first_name { "Test" }
    last_name { "User" }
  end
end
