class ChangeVotesUserIdToVoterId < ActiveRecord::Migration[5.1]
  def change
    rename_column :votes, :user_id, :voter_id
  end
end
