FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "test#{n}@gmail.com"}
    first_name { "Test" }
    last_name { "User" }
    password {"blahblah1234"}
  end
end
