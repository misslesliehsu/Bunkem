class AddDoneToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :done, :boolean, :default => false
  end
end
