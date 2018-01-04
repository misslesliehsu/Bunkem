class AddBattleToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :battle_id, :integer
  end
end
