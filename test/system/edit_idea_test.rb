require "application_system_test_case"

class EditIdeaTest < ApplicationSystemTestCase
  test "that editing an idea updates the idea in idea list" do
    idea = Idea.new title: 'Dummy title',
                    done_count: 12345,
                    photo_url: 'turtle-big.jpg',
                    user: User.new
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
