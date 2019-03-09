require 'rails_helper'
require 'capybara/rails'

describe "creating reviews -", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  it "authenticated user creates new review with all required fields populated" do
    user
    visit root_path
    find_link('sign in').click
    fill_in('email', with: 'test1@gmail.com')
    fill_in('password', with: 'blahblah1234')
    find_button('log in').click
    visit '/reviews/new'
    fill_in 'review_title', with: 'Test title'
    fill_in 'review_body', with: 'here is a sample description'
    find_button('submit').click
    page.has_content?('Test title')
    page.has_content?('here is a sample description')

  end

   it "authenticated user creates new review without all required fields populated" do
     user
     visit root_path
     find_link('sign in').click
     fill_in('email', with: 'test1@gmail.com')
     fill_in('password', with: 'blahblah1234')
     find_button('log in').click
     visit '/reviews/new'
     fill_in 'review_body', with: 'here is a sample description'
     find_button('submit').click
     page.has_content?("Title can't be blank")
   end

   it "unauthenticated user cannot create new review" do
     visit root_path
     find_link('add_new_review').click
     page.has_content?('You do not have access to this page')
   end
end

 describe "editing / deleting reviews -" do
   before :each do
     user
     find_link('sign in').click
     fill_in 'email', with: 'test1@gmail.com'
     fill_in 'password', with: 'blahblah1234'
     find_button('log in').click
     visit '/reviews/new'
     fill_in 'review_title', with: 'Test title'
     fill_in 'review_body', with: 'here is a sample description'
     find_button('submit').click
     find_link('sign out').click
   end

   it "allows authenticated author to edit their review successfully" do
     user

     #login
     visit root_path
     find_link('sign in').click
     fill_in 'email', with: 'test1@gmail.com'
     fill_in 'password', with: 'blahblah1234'
     find_button('log in').click

     #edit review
     find_link('all reviews').click
     find_link('Test title').click
     find_button('edit review').click
     fill_in 'review_title', with: 'Second test title'
     find_button('submit').click
     page.has_content?('Second test title')
   end

   it "user who is not the author of review can't edit review successfully" do
     user
     user_two = FactoryBot.create(:user)
     visit root_path
     find_link('sign in').click
     fill_in 'email', with: 'test2@gmail.com'
     fill_in 'password', with: 'blahblah1234'
     find_button('log in').click

     find_link('all reviews').click
     find_link('Test title').click
     expect(page).not_to have_button 'edit review'
   end

   it "allows authenticated author to delete their review successfully" do
     user
     visit root_path
     find_link('sign in').click
     fill_in 'email', with: 'test1@gmail.com'
     fill_in 'password', with: 'blahblah1234'
     find_button('log in').click

     #edit review
     find_link('all reviews').click
     find_link('Test title').click
     find_button('delete review').click
     find_button('OK').click
     expect(page).to have_content 'Your question has been deleted'
   end

   it "user who is not the author of review cannot delete review" do
     user
     user_two = FactoryBot.create(:user)
     visit root_path
     find_link('sign in').click
     fill_in 'email', with: 'test2@gmail.com'
     fill_in 'password', with: 'blahblah1234'
     find_button('log in').click

     find_link('all reviews').click
     find_link('Test title').click
     expect(page).not_to have_button 'delete review'
   end
 end

 describe "voting for reviews" do
   it "allows authenticated user to vote up or down a review" do
     user

     #login
     visit root_path
     find_link('sign in').click
     fill_in 'email', with: 'test1@gmail.com'
     fill_in 'password', with: 'blahblah1234'
     find_link('log in').click

     #up_vote review
     find_link('all reviews').click
     find_link('Test title').click
     find_link('thumbs_up').click
     expect(page).to have_content 'Thanks for voting'

     #down_vote review
     find_link('thumbs_down').click
     expect(page).to have_content 'Thanks for voting'
   end

   it "prevents authenticated user from voting up a review more than once" do
     user

     #login
     visit root_path
     find_link('sign in').click
     fill_in 'email', with: 'test1@gmail.com'
     fill_in 'password', with: 'blahblah1234'
     find_link('log in').click

     #up_vote review
     find_link('all reviews').click
     find_link('Test title').click
     find_link('thumbs_up').click
     expect(page).to have_content 'Thanks for voting'

     #up_vote again
     find_link('thumbs_up').click
     expect(page).to have_content "You've already voted up this review!"
   end

   it "prevents authenticated user from voting down a review more than once" do
     user

     #login
     visit root_path
     find_link('sign in').click
     fill_in 'email', with: 'test1@gmail.com'
     fill_in 'password', with: 'blahblah1234'
     find_link('log in').click

     #up_vote review
     find_link('all reviews').click
     find_link('Test title').click
     find_link('thumbs_down').click
     expect(page).to have_content 'Thanks for voting'

     #up_vote again
     find_link('thumbs_down').click
     expect(page).to have_content "You've already voted down this review!"
   end

   it "unauthenticated user can't vote for review" do
     visit root_path
     find_link('all reviews').click
     find_link('Test title').click
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
