require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test 'the partially complete Idea created is first in the list' do
    first_idea = Idea.new
    first_idea.title = 'first idea'
    first_idea.save!
    second_idea = Idea.new
    second_idea.title = 'second idea'
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
    idea.title = 'some title'
    idea.done_count = 34
    idea.save!
    first_updated_at = idea.updated_at
    idea.done_count = 151
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating photo_url' do
    idea = Idea.new
    idea.title = 'some idea'
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

  test 'search where only description matches' do
    idea_1 = Idea.new
    idea_1.title = 'Surfing in Portugal'
    idea_1.description = 'See what Atlantic coast waves are like!'
    idea_1.save!
    assert_equal 1, Idea.search('coast').length
  end

  test 'search where title and description match' do
    idea_1 = Idea.new
    idea_1.title = 'Overnight hike in Switzerland'
    idea_1.description = 'Stay in a Swiss refuge in the mountains.'
    idea_1.save!
    idea_2 = Idea.new
    idea_2.title = 'Hike the mountains in Italy'
    idea_2.description = 'See the Dolomites and Italian Alps.'
    idea_2.save!
    assert_equal 2, Idea.search('mountains').length
  end

  test 'most_recent method when there is no record' do
    assert_empty Idea.most_recent
  end

  test 'most_recent method when there are two records' do
    idea_1 = Idea.new
    idea_1.title = "Idea 1"
    idea_1.save!
    idea_2 = Idea.new
    idea_2.title = "Idea 2"
    idea_2.save!
    recent_ideas = Idea.most_recent
    assert_equal 2, recent_ideas.length
    assert_equal idea_2, recent_ideas[0]
  end

  test 'most_recent method when there are six records' do
    6.times do |i|
      idea = Idea.new
      idea.title = "Idea #{i+1}"
      idea.save!
    end

    recent_ideas = Idea.most_recent
    assert_equal 3, recent_ideas.length
    assert_equal 'Idea 6', recent_ideas[0].title
  end

  test 'idea title is too long' do
    idea_1 = Idea.new
    long_title = ''
    76.times do
      long_title += 'x'
    end
    refute idea_1.valid?
  end

  test 'idea title is missing' do
    idea_1 = Idea.new
    refute idea_1.valid?
  end

  test 'Comments are ordered correctly' do
    idea_1 = Idea.new title: 'some title'
    idea_1.save!
    comment_1 = Comment.new body: 'This would be great fun'
    comment_2 = Comment.new body: "I agree! I'd like to do this as well"
    idea_1.comments << comment_1
    idea_1.comments << comment_2
    idea_1.save!
    assert_equal comment_1, idea_1.comments.first
    assert_equal 2, idea_1.comments.length
  end

end
