require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test 'the first empty Idea created is first in the list' do
    first_idea = Idea.new
    first_idea.save!
    second_idea = Idea.new
    second_idea.save!
    assert_equal(first_idea, Idea.all.first)
  end

    test 'the first complete Idea created is first in the list' do
    first_idea = Idea.new
    first_idea.title = 'Cycle the length of the United Kingdom'
    first_idea.photo_url = 'http://mybucketlist.ch/an_image.jpg'
    first_idea.done_count = 12
    first_idea.save!
    second_idea = Idea.new
    second_idea.title = 'Visit Japan'
    second_idea.photo_url = 'http://mybucketlist.ch/second_image.jpg'
    second_idea.done_count = 3
    second_idea.save!
    assert_equal(first_idea, Idea.all.first)
  end

  test 'updated_at is changed after updating title' do
    idea = Idea.new
    idea.title = 'Visit Marrakech'
    idea.save!
    first_updated_at = idea.updated_at
    idea.title = 'Visit the market in Marrakech'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating done_count' do
    idea = Idea.new
    idea.done_count = 34
    idea.save!
    first_updated_at = idea.updated_at
    idea.done_count = 151
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating photo_url' do
    idea = Idea.new
    idea.photo_url = 'turtle-big.jpg'
    idea.save!
    first_updated_at = idea.updated_at
    idea.photo_url = 'northern-lights.jpg'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'search with one matching result' do
    idea = Idea.new
    idea.title = 'Stand at the top of the Empire State Building'
    idea.save!
    assert_equal(1, Idea.search('the top').length())
  end

  test 'search with no matching result' do
    idea = Idea.new
    idea.title = 'Stand at the top of the Empire State Building'
    idea.save!
    assert_empty(Idea.search('snorkelling'))
  end

  test 'search with two matching results' do
    idea_1 = Idea.new
    idea_1.title = 'Stand at the top of the Empire State Building'
    idea_1.save!
    idea_2 = Idea.new
    idea_2.title = 'Stand on the pyramids'
    idea_2.save!
    assert_equal(2, Idea.search('Stand').length())
  end

end
