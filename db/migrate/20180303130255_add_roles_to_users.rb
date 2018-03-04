class AddRolesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :creator_role, :boolean, default: false
    add_column :users, :solver_role, :boolean, default: true
  end
end
