class Idea < ApplicationRecord
  def self.search(search_term)
    where('title LIKE ?', "%#{search_term}%").or(where('description LIKE ?', "%#{search_term}%"))
  end

  def self.most_recent()
    all.order(created_at: :desc).limit(3)
  end
end
