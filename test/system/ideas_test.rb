require "application_system_test_case"

class IdeasTest < ApplicationSystemTestCase
  test 'create new idea' do
    title = 'Learn tango'
    visit ideas_new_path
    fill_in 'title', with: title
    fill_in 'done_count', with: '43'
    fill_in 'photo_url', with: 'turtle-big.jpg'
    click_on 'Create an idea'
    assert page.has_content? title
  end

  test 'display ideas in database' do
    idea1 = Idea.new( title: 'See the northern lights',
                      done_count: 3,
                      photo_url: 'http://fpoimg.com/255x170')
    idea1.save!
    idea2 = Idea.new( title: 'Swim with dolphins',
                      done_count: 3,
                      photo_url: 'http://fpoimg.com/255x170')
    idea2.save!
    idea3 = Idea.new( title: 'Shake hands with the president',
                      done_count: 3,
                      photo_url: 'http://fpoimg.com/255x170')
    idea3.save!
    visit account_ideas_path
    assert page.has_content? idea1.title
    assert page.has_content? idea2.title
    assert page.has_content? idea3.title
  end

  test 'search' do
    idea = Idea.new
    idea.title = 'Climb Mont Blanc'
    idea.save!
    idea = Idea.new
    idea.title = 'Visit Niagara Falls'
    idea.save!
    visit '/'
    fill_in 'q', with: 'Mont'
    click_on 'Search', match: :first
    assert current_path, ideas_index_path
    assert page.has_content? 'Climb Mont Blanc'
    refute page.has_content? 'Visit Niagara Falls'
  end
end
