require "application_system_test_case"

class EditIdeaTest < ApplicationSystemTestCase
  test "that editing an idea updates the idea in idea list" do
    idea = Idea.new
    idea.title = 'Dummy title'
    idea.done_count = 12345
    idea.photo_url = 'turtle-big.jpg'
    user = User.new email: 'jiw@netplus.ch'
    idea.user = user
    assert idea.save

    visit edit_idea_path(idea)
    fill_in 'Done count', with: 999
    fill_in 'Title', with: 'Another dummy title'
    click_on 'Update Idea'
    assert page.has_content? 'Another dummy title'
    click_on 'Another dummy title'
    assert page.has_content? 'Another dummy title'
    assert page.has_content? "999 have done this"
  end
end
