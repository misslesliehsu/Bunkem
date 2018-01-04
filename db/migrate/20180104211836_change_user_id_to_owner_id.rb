class ChangeUserIdToOwnerId < ActiveRecord::Migration[5.1]
  def change
    rename_column :games, :user_id, :owner_id
  end
end
