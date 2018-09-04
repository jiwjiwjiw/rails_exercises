require "application_system_test_case"

class IdeasTest < ApplicationSystemTestCase
  test 'create new idea' do
    user = User.new email: 'jiw@netplus.ch'
    user.save!
    visit new_user_path
    fill_in 'Email address', with: user.email
    click_on 'Log in', match: :first

    title = 'Learn tango'
    visit new_idea_path
    fill_in 'Title', with: title
    fill_in 'Done count', with: '43'
    fill_in 'Photo url', with: 'turtle-big.jpg'
    click_on 'Create Idea'
    assert page.has_content? title
  end

  test 'display ideas in database' do
    idea1 = Idea.new title: 'See the northern lights',
                     done_count: 3,
                     photo_url: 'http://fpoimg.com/255x170',
                     user: User.new
    idea1.save!
    idea2 = Idea.new title: 'Swim with dolphins',
                     done_count: 3,
                     photo_url: 'http://fpoimg.com/255x170',
                     user: User.new
    idea2.save!
    idea3 = Idea.new title: 'Shake hands with the president',
                     done_count: 3,
                     photo_url: 'http://fpoimg.com/255x170',
                     user: User.new
    idea3.save!
    visit account_ideas_path
    assert page.has_content? idea1.title
    assert page.has_content? idea2.title
    assert page.has_content? idea3.title
  end

  test 'that idea is displayed properly' do
    idea = Idea.new title: 'Test title',
                    done_count: 12345,
                    user: User.new
    idea.save!
    visit(idea_path(idea))
    assert page.has_content? 'Test title'
    assert page.has_content? 12345
    assert page.has_content? idea.created_at.strftime("%d %b '%y")
    click_on 'Edit', match: :first
    assert_equal current_path, edit_idea_path(idea)
  end

  test 'that a message informs user when no idea is present' do
    visit ideas_path
    assert page.has_content? 'No ideas found!'
  end

  test 'create idea with too long title leads to error message' do
    user = User.new email: 'jiw@netplus.ch'
    user.save!
    visit new_user_path
    fill_in 'Email address', with: user.email
    click_on 'Log in', match: :first

    visit new_idea_path
    long_title = ''
    76.times do
      long_title += 'x'
    end
    fill_in 'Title', with: long_title
    fill_in 'Done count', with: 41
    fill_in 'Description', with: 'Some description'
    fill_in 'Photo url', with: 'turtle-big.jpg'
    click_on 'Create Idea'
    assert page.has_content? 'Title is too long'
  end

  test 'edit idea with too long title leads to error message' do
    idea = Idea.new title: 'some title',
                    done_count: 3,
                    user: User.new
    idea.save!
    visit edit_idea_path(idea)
    long_title = ''
    76.times do
      long_title += 'x'
    end
    fill_in 'Title', with: long_title
    click_on 'Update Idea'
    assert page.has_content? 'Title is too long'
  end

end
