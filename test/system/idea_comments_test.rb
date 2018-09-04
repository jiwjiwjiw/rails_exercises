require "application_system_test_case"

class IdeaCommentsTest < ApplicationSystemTestCase
  test 'adding a Comment to an Idea' do
    user = User.new email: 'jiw@netplus.ch'
    user.save!
    visit new_user_path
    fill_in 'Email address', with: user.email
    click_on 'Log in', match: :first

    idea = Idea.new title: 'Test idea'
    idea.save!
    visit idea_path(idea)
    fill_in 'Add a comment', with: 'Some dummy comment'
    click_on 'Post', match: :first

    assert_equal idea_path(idea), page.current_path
    assert page.has_content? 'Some dummy comment'
  end

  test 'comments cannot be added when not logged in' do
    idea = Idea.new title: 'some title'
    idea.save!
    visit idea_path(idea)
    refute page.has_content? 'Add a comment'
  end

end
