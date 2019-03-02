require 'rails_helper'

RSpec.describe User, type: :model do
  it "#initialize" do
    user = FactoryBot.create(:user)
    expect(user.email).to include("@gmail.com")
    expect(user.first_name).to_not be_nil
    expect(user.last_name).to_not be_nil
  end
end
