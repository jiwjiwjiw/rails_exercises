require "application_system_test_case"

class HomePageTest < ApplicationSystemTestCase
  test 'that home page displays the three most recent ideas' do
    idea_1 = Idea.new
    idea_1.title = 'Idea 1'
    idea_1.save!
    idea_2 = Idea.new
    idea_2.title = 'Idea 2'
    idea_2.save!
    idea_3 = Idea.new
    idea_3.title = 'Idea 3'
    idea_3.save!
    idea_4 = Idea.new
    idea_4.title = 'Idea 4'
    idea_4.save!

    visit root_path
    assert page.has_content? 'Idea 4'
    assert page.has_content? 'Idea 3'
    assert page.has_content? 'Idea 2'
  end
end
