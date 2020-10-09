require 'rails_helper'

RSpec.feature "Groups", type: :feature do
  before(:each) do
    visit signup_path
    within('form') do
      fill_in 'Name', with: 'user1'
      fill_in 'Password', with: 135792468
    end
    click_button 'Create User'
  end
  it 'allows user to create new group' do
    click_link 'All Groups'
    click_link 'New Group'
    within('form') do
      fill_in 'Name', with: 'Music'
      fill_in 'Icon', with: '<i class="fas fa-music"></i>'
    end
    click_button 'Submit'
    expect(page).to have_content('Group was successfully created.')
  end
  it 'Prohibits user from creating a group without a name' do
    click_link 'All Groups'
    click_link 'New Group'
    within('form') do
      fill_in 'Icon', with: '<i class="fas fa-music"></i>'
    end
    click_button 'Submit'
    expect(page).to have_content("Name can't be blank")
  end
end
