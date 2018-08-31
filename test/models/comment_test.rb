require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'changing the associated Idea for a Comment' do
    idea_1 = Idea.new title: 'some title'
    idea_1.save!
    comment = Comment.new body: "I'd like to do this!", idea: idea_1
    comment.save!
    idea_2 = Idea.new title: 'some other title'
    idea_2.save!
    comment.idea = idea_2
    comment.save!
    assert_equal idea_2 Comment.first.idea
  end
end
