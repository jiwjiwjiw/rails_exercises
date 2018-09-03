require "application_system_test_case"

class IdeaCommentsTest < ApplicationSystemTestCase
  test 'adding a Comment to an Idea' do
    idea = Idea.new title: 'Test idea'
    idea.save!
    visit idea_path(idea)
    fill_in 'Body', with: 'Some dummy comment'
    click_on 'Create Comment', match: :first
    assert_equal idea_path(idea), current_path
    assert page.has_content? 'Some dummy comment'
  end
end
