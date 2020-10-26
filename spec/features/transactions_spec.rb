require 'rails_helper'

RSpec.feature 'Transactions', type: :feature do
  before(:each) do
    visit signup_path
    within('form') do
      fill_in 'Name', with: 'user1'
      fill_in 'Password', with: 135_792_468
    end
    click_button 'Create User'
  end
  it 'allows user to create new transaction' do
    click_link 'New Transaction'
    within('form') do
      fill_in 'Name', with: 'Buy some Cds'
      fill_in 'Amount', with: 35.8
    end
    click_button 'Submit'
    expect(page).to have_content('Transaction was successfully created.')
  end
  it 'Prohibits user from creating a Transaction without a name' do
    click_link 'New Transaction'
    within('form') do
      fill_in 'Amount', with: 35.8
    end
    click_button 'Submit'
    expect(page).to have_content("Name can't be blank")
  end
end
RSpec.feature 'Transactions', type: :feature do
  before(:each) do
    visit signup_path
    within('form') do
      fill_in 'Name', with: 'user1'
      fill_in 'Password', with: 135_792_468
    end
    click_button 'Create User'
  end
  it 'Prohibits user from creating a Transaction without amount' do
    click_link 'New Transaction'
    within('form') do
      fill_in 'Name', with: 'Buy some Cds'
    end
    click_button 'Submit'
    expect(page).to have_content("Amount can't be blank")
  end
end
