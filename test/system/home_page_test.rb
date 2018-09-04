require "application_system_test_case"

class HomePageTest < ApplicationSystemTestCase
  test 'that home page displays the three most recent ideas' do
    user = User.new email: 'jiw@netplus.ch'
    4.times do |i|
      idea = Idea.new
      idea.title = "Idea #{i+1}"
      idea.user = user
      idea.save!
    end

    visit root_path
    assert page.has_content? 'Idea 4'
    assert page.has_content? 'Idea 3'
    assert page.has_content? 'Idea 2'
    refute page.has_content? 'Idea 1'
  end
end
