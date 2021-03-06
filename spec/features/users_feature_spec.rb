require 'rails_helper'
require_relative 'helpers/application'

include ApplicationHelper

context "user not signed in and on the homepage" do
  it "should see a 'sign in' link and a 'sign up' link" do
    visit '/'
    expect(page).to have_link 'Sign in'
    expect(page).to have_link 'Sign up'
  end

  it "should not see 'sign out' link" do
    visit '/'
    expect(page).not_to have_link 'Sign out'
  end
end

context "user signed in on the homepage" do

  before do
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'testtest'
    fill_in 'Password confirmation', with: 'testtest'
    click_button 'Sign up'
  end

  it "should see 'sign out' link" do
    visit '/'
    expect(page).to have_link 'Sign out'
  end

  it "should not see a 'sign in' link and a 'sign up' link" do
    visit '/'
    expect(page).not_to have_link 'Sign in'
    expect(page).not_to have_link 'Sign up'
  end
end

context "signing in" do

  it "prompts the user for their name" do
    visit '/'
    click_link 'Sign up'
    expect(page).to have_content 'Name'
  end

  it 'takes the user to a second page to add more details' do
    visit '/'
    sign_up_one
    expect(current_path).to eq '/users/edit'
  end

  it 'redirects them to the homepage once they have added in more details' do
    visit '/'
    sign_up_one
    fill_in 'Level', with: 'Beginner'
    fill_in 'Choice', with: 'Board'
    fill_in 'Number', with: '3453'
    click_button 'Update'
    expect(current_path).to eq '/events'
  end



end
