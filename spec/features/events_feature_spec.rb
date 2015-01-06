require 'rails_helper'
require_relative 'helpers/application'

include ApplicationHelper

describe 'creating an event' do
  before do
    visit '/'
    sign_up_one
    create_event
    visit '/'
  end

  it 'prompts the user to fill in a form, then displays the new event' do
    expect(page).to have_content 'Pleney'
  end

  it 'displays the name of the creator' do
    expect(page).to have_content 'testOne'
  end

  it 'displays the event level' do
    expect(page).to have_content 'Beginner'
  end

  it 'displays the event plan' do
    expect(page).to have_content 'Piste'
  end

  it 'displays the event group size' do
    expect(page).to have_content '2'
  end

  it "it doesn't show the creator a 'Join' button" do
    expect(page).not_to have_link 'Join'
  end

end

describe 'to join an event' do
  before do
    sign_up_one
    create_event
    sign_out
    sign_up_two
    visit '/'
  end

  it 'it shows a join button on the events page' do
    expect(page).to have_link 'Join'
  end

  it 'it asks the user to confirm they want to join the event' do
    click_link 'Join'
    expect(page).to have_content "You've joined the group. Your number will be sent"
  end

  it 'it adds the user to the event' do
    click_link 'Join'
    expect(AttendingEvent.count).to eq(1)
  end

  it 'is only possible if there is still space left' do
    click_link 'Join'
    sign_out
    sign_up_three
    visit '/'
    click_link 'Join'
    sign_out
    sign_up_four
    visit '/'
    expect(page).not_to have_link 'Join'
  end

  it 'removes the join button' do
    click_link 'Join'
    expect(page).not_to have_link 'Join'
  end

end
