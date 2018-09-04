require "application_system_test_case"

class SearchTest < ApplicationSystemTestCase
  test 'search' do
    idea_1 = Idea.new title: 'Climb Mont Blanc',
                      user: User.new
    idea_1.save!
    idea_2 = Idea.new title: 'Visit Niagara Falls',
                      user: User.new
    idea_2.save!
    visit '/'
    fill_in 'q', with: 'Mont'
    click_on 'Search', match: :first
    assert current_path, ideas_path
    assert page.has_content? 'Climb Mont Blanc'
    refute page.has_content? 'Visit Niagara Falls'
  end

  test 'search on title and description fields' do
    idea_1 = Idea.new title: 'Go cycling across Europe',
                      description: 'An amazing way to see lots of Europe',
                      user: User.new
    idea_1.save!
    idea_2 = Idea.new title: 'Visit Provence',
                      description: 'Go to vineyards, go cycling up Mont Ventoux, see the fields of lavender',
                      user: User.new
    idea_2.save!
    idea_3 = Idea.new title: 'Overnight hike in Switzerland',
                      description: 'Stay in a Swiss refuge in the mountains.',
                      user: User.new
    idea_3.save!

    visit root_path
    fill_in 'q', with: 'cycling'
    click_on 'Search', match: :first
    assert page.has_content? 'Go cycling across Europe'
    assert page.has_content? 'Visit Provence'
    refute page.has_content? 'Overnight hike in Switzerland'
  end
end
