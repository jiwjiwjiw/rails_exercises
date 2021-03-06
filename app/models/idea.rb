class Idea < ApplicationRecord
  has_many :comments
  belongs_to :user
  has_and_belongs_to_many :users
  validates :title, presence: true
  validates :title, length: { maximum: 75 }

  def self.search(search_term)
    wildcard_filter = "%#{search_term}%"
    where('title LIKE ?', wildcard_filter).or(where('description LIKE ?', wildcard_filter))
  end

  def self.most_recent()
    all.order(created_at: :desc).limit(3)
  end
end
