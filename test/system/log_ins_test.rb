require "application_system_test_case"

class LogInsTest < ApplicationSystemTestCase
  test 'sign up creates a User' do
    visit new_user_path
    fill_in 'Email address', with: 'jiw@netplus.ch'
    click_on'Log in', match: :first
    assert_equal 1, User.all.length
    assert_equal 'jiw@netplus.ch', User.first.email
  end

  test 'log in does not create a User' do
    user = User.new email: 'jiw@netplus.ch'
    user.save!
    visit new_user_path
    fill_in 'Email address', with: 'jiw@netplus.ch'
    click_on'Log in', match: :first
    assert_equal 1, User.all.length
  end
end
