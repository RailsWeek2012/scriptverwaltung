class AddUserIdToScripts < ActiveRecord::Migration
  def change
    add_column :scripts, :user_id, :integer
    add_column :scripts, :activated, :boolean, default: false
  end
end
