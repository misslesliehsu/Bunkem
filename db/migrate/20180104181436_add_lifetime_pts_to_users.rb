class AddLifetimePtsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :lifetime_pts, :integer, :default => 0
  end
end
