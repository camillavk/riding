require 'rails_helper'
require_relative 'helpers/application'

include ApplicationHelper

describe 'creating an event' do
  before do
    visit '/'
    click_link 'Sign up'
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button 'Sign up'
  end

  it 'prompts the user to fill in a form, then displays the new event' do
    click_link 'Add'
    select('Today', :from => 'When are you riding?')
    fill_in 'Where are you riding?', with: 'Pleney'
    choose 'event_level_beginner'
    choose 'event_plan_piste'
    select_time(Time.now, :from => 'event_meeting')
    select('Three', :from => 'Max group size')
    click_button 'Submit'
    expect(page).to have_content 'Pleney'
  end
end

describe 'joining an event' do
  before do
    sign_up_one
    create_event
    sign_out
    sign_up_two
  end

  it 'asks the user to confirm they want to join the event' do
    click_link 'Join'
    expect(page).to have_content "Clicking 'join' will send your number to the event organizer"
  end

end
