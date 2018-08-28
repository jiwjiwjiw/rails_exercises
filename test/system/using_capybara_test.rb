require 'application_system_test_case'

Capybara.run_server = false

class CapybaraTest < ApplicationSystemTestCase
  test 'capybara works' do
    visit('http://www.google.com')
    sleep(5.seconds)
    fill_in('q', with: 'Cinque Terre')
    sleep(3.seconds)
    click_on('Recherche Google', match: :first)
    sleep(3.seconds)
    click_on('Wikipédia', match: :first)
    sleep(3.seconds)
    click_on('Riviera', match: :first)
    sleep(3.seconds)
    click_on('Guides')
    sleep(20.seconds)
  end
end
