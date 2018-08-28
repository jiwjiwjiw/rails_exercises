require "application_system_test_case"

class IdeasTest < ApplicationSystemTestCase
  test 'create new idea' do
    visit ideas_new_path
    fill_in 'title', with: 'Learn tango'
    fill_in 'done_count', with: '43'
    fill_in 'photo_url', with: 'turtle-big.jpg'
    click_on 'Create an idea'
  end
end
