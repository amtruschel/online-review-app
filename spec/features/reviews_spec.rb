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

  it "authenticated user creates new review without all required fields populated" do
    user
    visit root_path
    click_link 'sign in'
    fill_in 'email', with: 'test1@gmail.com'
    fill_in 'password', with: 'blahblah1234'
    click_button 'log in'
    visit '/reviews/new'
    fill_in 'review_body', with: 'here is a sample description'
    click_button 'submit'

    expect(page).to have_content "Title can't be blank"
  end

  it "unauthenticated user cannot create new review" do
    visit 'root_path'
    click_link ' add review'
    expect(page).to have_content 'You do not have access to this page'
  end

end

describe "editing / deleting reviews -" do
  before :each do
    user
    click_link 'sign in'
    fill_in 'email', with: 'test1@gmail.com'
    fill_in 'password', with: 'blahblah1234'
    click_button 'log in'
    visit '/reviews/new'
    fill_in 'review_title', with: 'Test title'
    fill_in 'review_body', with: 'here is a sample description'
    click_button 'submit'
    click_link 'sign out'
  end

  it "allows authenticated author to edit their review successfully" do
    user

    #login
    visit root_path
    click_link 'sign in'
    fill_in 'email', with: 'test1@gmail.com'
    fill_in 'password', with: 'blahblah1234'
    click_button 'log in'

    #edit review
    click_link 'all reviews'
    click_link 'Test title'
    click_button 'edit review'
    fill_in 'review_title', with: 'Second test title'
    click_button 'submit'
    expect(page).to have_content 'Second test title'
  end

  it "user who is not the author of review can't edit review successfully" do
    user
    user_two = FactoryBot.create(:user)
    visit root_path
    click_link 'sign in'
    fill_in 'email', with: 'test2@gmail.com'
    fill_in 'password', with: 'blahblah1234'
    click_button 'log in'

    click_link 'all reviews'
    click_link 'Test title'
    expect(page).not_to have_button 'edit review'
  end

  it "allows authenticated author to delete their review successfully" do
    user
    visit root_path
    click_link 'sign in'
    fill_in 'email', with: 'test1@gmail.com'
    fill_in 'password', with: 'blahblah1234'
    click_button 'log in'

    #edit review
    click_link 'all reviews'
    click_link 'Test title'
    click_button 'delete review'
    click_button 'OK'
    expect(page).to have_content 'Your question has been deleted'
  end

  it "user who is not the author of review cannot delete review" do
    user
    user_two = FactoryBot.create(:user)
    visit root_path
    click_link 'sign in'
    fill_in 'email', with: 'test2@gmail.com'
    fill_in 'password', with: 'blahblah1234'
    click_button 'log in'

    click_link 'all reviews'
    click_link 'Test title'
    expect(page).not_to have_button 'delete review'
  end

end

describe "voting for reviews" do
  it "allows authenticated user to vote up or down a review" do
    user

    #login
    visit root_path
    click_link 'sign in'
    fill_in 'email', with: 'test1@gmail.com'
    fill_in 'password', with: 'blahblah1234'
    click_button 'log in'

    #up_vote review
    click_link 'all reviews'
    click_link 'Test title'
    click_link 'thumbs_up'
    expect(page).to have_content 'Thanks for voting'

    #down_vote review
    click_link 'thumbs_down'
    expect(page).to have_content 'Thanks for voting'
  end

  it "unauthenticated user can't vote for review" do
    visit root_path
    click_link 'all reviews'
    click_link 'Test title'
    expect(page).not_to have_link 'thumbs_up'
    expect(page).not_to have_link 'thumbs_down'
  end

end

describe "searching for reviews -" do
  it "allows users to search for reviews by substring" do
    visit root_path
    fill_in 'q', with: 'Test'
    expect(page).to have_content 'search results for "Test"'
    expect(page).to have_link 'Test title'
  end
end
