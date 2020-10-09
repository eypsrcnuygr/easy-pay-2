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
  it 'prohibits user to to log in with incorrext password' do
    click_link 'Logout'
    click_link 'SignIn'
    within('form') do
      fill_in 'Name', with: 'user1'
      fill_in 'Password', with: 1357924689
    end
    click_button 'Sign In'
    expect(page).to have_content('There was something wrong with your login information')
    expect { visit(user_path(5)) }.to raise_error(ActiveRecord::RecordNotFound)
  end
  it 'prohibits user to to log in with incorrext name' do
    click_link 'Logout'
    click_link 'SignIn'
    within('form') do
      fill_in 'Name', with: 'user'
      fill_in 'Password', with: 135792468
    end
    click_button 'Sign In'
    expect(page).to have_content('There was something wrong with your login information')
    expect { visit(user_path(6)) }.to raise_error(ActiveRecord::RecordNotFound)
  end
  it 'prevent not-logged in user to navigate through new transaction' do
    click_link 'Logout'
    visit(new_transaction_path)
    expect(page).to have_content('You are not authorized to continue')
  end
  it 'prevent not-logged in user to navigate through groups' do
    click_link 'Logout'
    visit(groups_path)
    expect(page).to have_content('You are not authorized to see this page')
  end
  it 'prevent not-logged in user to navigate through users' do
    click_link 'Logout'
    visit(users_path)
    expect(page).to have_content('You are not authorized to see this page')
  end
  it 'prevent not-logged in user to navigate through transactions' do
    click_link 'Logout'
    visit(transactions_path)
    expect(page).to have_content('You are not authorized to continue')
  end
end
