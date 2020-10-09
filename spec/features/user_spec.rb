require 'rails_helper'

RSpec.feature "Users", type: :feature do
  before(:each) do
    visit signup_path
    within('form') do
      fill_in 'Name', with: 'user1'
      fill_in 'Password', with: 135792468
    end
    click_button 'Create User'
  end
  it 'Redirects user to user page for the first time' do
    expect(page).to have_content("You haven't created any group!")
  end
  it 'allows user to navigate to new transaction page' do
    click_link 'New Transaction'
    expect(page).to have_content('Name')
    expect(page).to have_content('Amount')
  end
  it 'allows user to log out' do
    click_link 'Logout'
    expect(page).to have_content('logged out')
    expect(page).to have_content('Login')
  end
  it 'allows user to log in' do
    click_link 'Logout'
    click_link 'SignIn'
    within('form') do
      fill_in 'Name', with: 'user1'
      fill_in 'Password', with: 135792468
    end
    click_button 'Sign In'
    expect(page).to have_content('Logged in succesfuly')
    expect(page).to have_content('Logout')
  end
end
