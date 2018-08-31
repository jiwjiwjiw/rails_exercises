class AddDescriptionToIdeas < ActiveRecord::Migration[5.1]
  def change
    add_column :ideas, :description, :string
  end
end
