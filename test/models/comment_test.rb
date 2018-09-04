require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'changing the associated Idea for a Comment' do
    idea_1 = Idea.new title: 'some title',
                      user: User.new
    idea_1.save!
    comment = Comment.new body: "I'd like to do this!",
                          idea: idea_1,
                          user: User.new
    comment.save!
    idea_2 = Idea.new title: 'some other title',
                      user: User.new
    idea_2.save!
    comment.idea = idea_2
    comment.save!
    assert_equal idea_2, Comment.first.idea
  end

  test 'cascading save' do
    idea_1 = Idea.new title: 'some title',
                      user: User.new
    idea_1.save!
    comment = Comment.new body: "Great idea!",
                          user: User.new
    idea_1.comments << comment
    idea_1.save!
    assert_equal comment, Comment.first
  end

end
