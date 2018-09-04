require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test 'the partially complete Idea created is first in the list' do
    first_idea = Idea.new title: 'first idea',
                          user: User.new
    first_idea.save!
    second_idea = Idea.new title: 'second idea',
                          user: User.new
    second_idea.save!
    assert_equal(first_idea, Idea.all.first)
  end

    test 'the first complete Idea created is first in the list' do
    first_idea = Idea.new title: 'Cycle the length of the United Kingdom',
                          photo_url: 'http://mybucketlist.ch/an_image.jpg',
                          done_count: 12,
                          user: User.new
    first_idea.save!
    second_idea = Idea.new title: 'Visit Japan',
                          photo_url: 'http://mybucketlist.ch/second_image.jpg',
                          done_count: 3,
                          user: User.new
    second_idea.save!
    assert_equal(first_idea, Idea.all.first)
  end

  test 'updated_at is changed after updating title' do
    idea = Idea.new title: 'Visit Marrakech',
                    user: User.new
    idea.save!
    first_updated_at = idea.updated_at
    idea.title = 'Visit the market in Marrakech'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating done_count' do
    idea = Idea.new title: 'some title',
                    done_count: 34,
                    user: User.new
    idea.save!
    first_updated_at = idea.updated_at
    idea.done_count = 151
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating photo_url' do
    idea = Idea.new title: 'some idea',
                    photo_url: 'turtle-big.jpg',
                    user: User.new
    idea.save!
    first_updated_at = idea.updated_at
    idea.photo_url = 'northern-lights.jpg'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'search with one matching result' do
    idea = Idea.new title: 'Stand at the top of the Empire State Building',
                    user: User.new
    idea.save!
    assert_equal(1, Idea.search('the top').length())
  end

  test 'search with no matching result' do
    idea = Idea.new title: 'Stand at the top of the Empire State Building',
                    user: User.new
    idea.save!
    assert_empty(Idea.search('snorkelling'))
  end

  test 'search with two matching results' do
    idea_1 = Idea.new title: 'Stand at the top of the Empire State Building',
                    user: User.new
    idea_1.save!
    idea_2 = Idea.new title: 'Stand on the pyramids',
                      user: User.new
    idea_2.save!
    assert_equal(2, Idea.search('Stand').length())
  end

  test 'search where only description matches' do
    idea = Idea.new title: 'Surfing in Portugal',
                    description: 'See what Atlantic coast waves are like!',
                    user: User.new
    idea.save!
    assert_equal 1, Idea.search('coast').length
  end

  test 'search where title and description match' do
    idea_1 = Idea.new title: 'Overnight hike in Switzerland',
                      description: 'Stay in a Swiss refuge in the mountains.',
                      user: User.new
    idea_1.save!
    idea_2 = Idea.new title: 'Hike the mountains in Italy',
                      description: 'See the Dolomites and Italian Alps.',
                      user: User.new
    idea_2.save!
    assert_equal 2, Idea.search('mountains').length
  end

  test 'most_recent method when there is no record' do
    assert_empty Idea.most_recent
  end

  test 'most_recent method when there are two records' do
    idea_1 = Idea.new title: "Idea 1",
                      user: User.new
    idea_1.save!
    idea_2 = Idea.new title: "Idea 2",
                      user: User.new
    idea_2.save!
    recent_ideas = Idea.most_recent
    assert_equal 2, recent_ideas.length
    assert_equal idea_2, recent_ideas[0]
  end

  test 'most_recent method when there are six records' do
    6.times do |i|
      idea = Idea.new title: "Idea #{i+1}",
                      user: User.new
      idea.save!
    end

    recent_ideas = Idea.most_recent
    assert_equal 3, recent_ideas.length
    assert_equal 'Idea 6', recent_ideas[0].title
  end

  test 'idea title is too long' do
    idea = Idea.new
    long_title = ''
    76.times do
      long_title += 'x'
    end
    idea.title = long_title
    refute idea.valid?
  end

  test 'idea title is missing' do
    idea = Idea.new
    refute idea.valid?
  end

  test 'Comments are ordered correctly' do
    idea = Idea.new title: 'some title',
                    user: User.new
    idea.save!
    comment_1 = Comment.new body: 'This would be great fun',
                            user: User.new
    comment_2 = Comment.new body: "I agree! I'd like to do this as well",
                            user: User.new
    idea.comments << comment_1
    idea.comments << comment_2
    idea.save!
    assert_equal comment_1, idea.comments.first
    assert_equal 2, idea.comments.length
  end

end
