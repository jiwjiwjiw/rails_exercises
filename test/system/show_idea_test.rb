require "application_system_test_case"

class ShowIdeaTest < ApplicationSystemTestCase
  test 'that idea is displayed properly' do
    idea = Idea.new
    idea.title = 'Test title'
    idea.done_count = 12345
    idea.save!
    visit(show_idea_path(idea))
    assert page.has_content? 'Test title'
    assert page.has_content? 12345
    assert page.has_content? idea.created_at.strftime("%d %b '%y")
    click_on 'Edit', match: :first
    assert_equal current_path, edit_idea_path(idea)
  end
end
