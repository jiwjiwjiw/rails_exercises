require "application_system_test_case"

class SearchTest < ApplicationSystemTestCase
  test 'search' do
    idea_1 = Idea.new
    idea_1.title = 'Climb Mont Blanc'
    user = User.new email: 'jiw@netplus.ch'
    idea_1.user = user
    idea_1.save!
    idea_2 = Idea.new
    idea_2.title = 'Visit Niagara Falls'
    idea_2.user = user
    idea_2.save!
    visit '/'
    fill_in 'q', with: 'Mont'
    click_on 'Search', match: :first
    assert current_path, ideas_path
    assert page.has_content? 'Climb Mont Blanc'
    refute page.has_content? 'Visit Niagara Falls'
  end

  test 'search on title and description fields' do
    idea_1 = Idea.new
    idea_1.title = 'Go cycling across Europe'
    idea_1.description = 'An amazing way to see lots of Europe'
    user = User.new email: 'jiw@netplus.ch'
    idea_1.user = user
    idea_1.save!
    idea_2 = Idea.new
    idea_2.title = 'Visit Provence'
    idea_2.description = 'Go to vineyards, go cycling up Mont Ventoux, see the fields of lavender'
    idea_2.user = user
    idea_2.save!
    idea_3 = Idea.new
    idea_3.title = 'Overnight hike in Switzerland'
    idea_3.description = 'Stay in a Swiss refuge in the mountains.'
    idea_3.user = user
    idea_3.save!

    visit root_path
    fill_in 'q', with: 'cycling'
    click_on 'Search', match: :first
    assert page.has_content? 'Go cycling across Europe'
    assert page.has_content? 'Visit Provence'
    refute page.has_content? 'Overnight hike in Switzerland'
  end
end
