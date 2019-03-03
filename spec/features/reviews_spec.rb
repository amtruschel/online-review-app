require 'rails_helper'
require 'capybara/rails'

describe "creating reviews -", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  it "authenticated user creates new review with all required fields populated" do
    user
    visit root_path
    click_link 'sign in'
    fill_in 'email', with: 'test1@gmail.com'
    fill_in 'password', with: 'blahblah1234'
    click_button 'log in'
    visit '/reviews/new'
    fill_in 'review_title', with: 'Test title'
    fill_in 'review_body', with: 'here is a sample description'
    click_button 'submit'
    save_and_open_page
    expect(page).to have_content 'Test title'
    expect(page).to have_content 'here is a sample description'
    expect(page).to have_button 'edit review'
    expect(page).to have_button 'delete review'

  end

  # it "authenticated user creates new review without all required fields populated" do
  #   user
  #   visit root_path
  #   click_link 'sign in'
  #   fill_in 'email', with: 'test1@gmail.com'
  #   fill_in 'password', with: 'blahblah1234'
  #   click_button 'log in'
  #   visit '/reviews/new'
  #   fill_in 'review[body]', with: 'here is a sample description'
  #   click_button 'submit'
  #
  #   expect(page).to have_content "Title can't be blank"
  # end
  #
  # it "unauthenticated user creates new review" do
  #
  # end

end
