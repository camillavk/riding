module ApplicationHelper

  def sign_up_one
    visit '/'
    click_link 'Sign up'
    fill_in('Name', with: 'testOne')
    fill_in('Email', with: 'testOne@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button 'Sign up'
  end

  def sign_up_two
    visit '/'
    click_link 'Sign up'
    fill_in('Name', with: 'testTwo')
    fill_in('Email', with: 'testTwo@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button 'Sign up'
  end

  def sign_out
    visit '/'
    click_link 'Sign out'
  end

  def create_event
    visit '/'
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

  def select_time(time, options = {})
    field = options[:from]
    select time.strftime('%H'), :from => "#{field}_4i"
    select time.strftime('%M'), :from => "#{field}_5i"
  end


end
