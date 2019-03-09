require 'rails_helper'

feature "user auth:" do
  let(:user) { FactoryBot.create(:user) }

  scenario "new user creates account" do
    visit root_path
    click_link "sign in"
    click_link "sign up"
    fill_in 'first name', with: "Test"
    fill_in 'last name', with: "User"
    fill_in 'email', with: "test1@gmail.com"
    fill_in 'password', with: "password123"
    fill_in 'password confirmation', with: "password123"
    click_button 'sign up'

    expect(page).to have_content "Welcome! You have signed up successfully."
    expect(page).to have_link('sign out')
  end

  scenario "current user signs in" do
    email = "test1@gmail.com"
    pw = "password123"

    #create new user and then logout
    visit root_path
    click_link "sign in"
    click_link "sign up"
    fill_in 'first name', with: "test"
    fill_in 'last name', with: "user"
    fill_in 'email', with: email
    fill_in 'password', with: pw
    fill_in 'password confirmation', with: pw
    click_button 'sign up'
    expect(page).to have_content "Welcome! You have signed up successfully."
    click_link 'sign out'

    #sign in as previously created user
    click_link "sign in"
    fill_in 'email', with: email
    fill_in 'password', with: pw
    click_button 'log in'
    expect(page).to have_content "Signed in successfully."
    expect(page).to have_link('sign out')
  end

  scenario "current user signs out" do
    email = "test1@gmail.com"
    pw = "password123"

    #create new user and then logout
    visit root_path
    click_link "sign in"
    click_link "sign up"
    fill_in 'first name', with: "test"
    fill_in 'last name', with: "user"
    fill_in 'email', with: email
    fill_in 'password', with: pw
    fill_in 'password confirmation', with: pw
    click_button 'sign up'
    expect(page).to have_content "Welcome! You have signed up successfully."
    click_link 'sign out'

    #sign in as previously created user
    click_link "sign in"
    fill_in 'email', with: email
    fill_in 'password', with: pw
    click_button 'log in'
    expect(page).to have_content "Signed in successfully."
    expect(page).to have_link('sign out')

    click_link "sign out"
    expect(page).to have_content "Signed out successfully."
    expect(page).to have_link('sign in')
  end

end
