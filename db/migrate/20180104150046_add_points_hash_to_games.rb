class AddPointsHashToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :points_hash, :text
  end
end
