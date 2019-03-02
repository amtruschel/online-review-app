require 'rails_helper'
require 'capybara/rails'

describe "creating new reviews", type: :feature do
  it "authenticated user creates new review with all required fields populated" do
    user = FactoryBot.create(:user)
    visit root_path
    click_link 'sign in'
    fill_in 'email', with: 'test1@gmail.com'
    fill_in 'password', with: 'blahblah1234'
    click_button 'log in'
    visit '/reviews/new'
    fill_in 'Title', with: 'Test title'
    fill_in 'Description', with: 'here is a sample description'
    click_button 'submit'

    expect(page).to have_content 'Test title'
    expect(page).to have_content 'here is a sample description'
    expect(page).to have_button 'edit review'
    expect(page).to have_button 'delete review'

  end

  it "authenticated user creates new review without all required fields populated" do

  end

  it "unauthenticated user creates new review" do

  end

end
