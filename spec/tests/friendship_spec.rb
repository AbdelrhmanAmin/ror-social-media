require 'rails_helper'

describe 'Friendship', type: :feature do
  before :each do
    User.create(name: 'Abdo', email: 'Abdo@yahoo.com', password: '123456')
    User.create(name: 'Ali', email: 'Ali@yahoo.com', password: '123456')
    visit '/users/sign_in'
    fill_in 'user_email', with: 'Abdo@yahoo.com'
    fill_in 'user_password', with: '123456'
    find("input[type='submit']").click
  end

  it 'Add friend' do
    visit '/users'
    click_on('ADD')
    click_on('Sign out')
    fill_in 'user_email',	with: 'Ali@yahoo.com'
    fill_in 'user_password', with: '123456'
    find("input[type='submit']").click
    visit '/users'
    expect(page).to have_content('Accept')
  end

  it 'Should not send request, when a request has already been sent' do
    visit '/users'
    click_on('ADD')
    visit '/users'
    expect(page).not_to have_text('ADD')
  end
  it 'Accept Friendship' do
    visit '/users'
    click_on('ADD')
    click_on('Sign out')
    fill_in 'user_email', with: 'Ali@yahoo.com'
    fill_in 'user_password', with: '123456'
    find("input[type='submit']").click
    visit '/users'
    click_on('Accept')
  end
  it 'Reject Friendship' do
    visit '/users'
    click_on('ADD')
    click_on('Sign out')
    fill_in 'user_email', with: 'Ali@yahoo.com'
    fill_in 'user_password', with: '123456'
    find("input[type='submit']").click
    visit '/users'
    click_on('Reject')
    expect(page).to_not have_text('Accept')
  end
end
