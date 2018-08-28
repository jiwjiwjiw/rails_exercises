require "application_system_test_case"

class SimpleNavigationsTest < ApplicationSystemTestCase
  test 'search term is displayed' do
     visit('/')
     assert page.has_content?('Bucket List')
     fill_in('q', with: 'Spain').send_keys(:enter)
     assert has_content?('Spain')
     assert current_url.include?('q=Spain')
   end

   test 'style guide navigation' do
     visit('/')
     click_on('Styleguide', match: :first)
     sleep(3.seconds)
     assert current_url == styles_index_path
     assert has_content?('Atoms')
     assert has_content?('Molecules')
     click_on('Molecules', match: :first)
     sleep(3.seconds)
     assert current_url == styles_molecules_path
     assert has_content?('Card')
     click_on('My Bucket List', match: :first)
     sleep(3.seconds)
     assert current_url == root_path
     click_on('My Ideas', match: :first)
     sleep(5.seconds)
   end
 end
