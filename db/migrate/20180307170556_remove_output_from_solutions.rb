class RemoveOutputFromSolutions < ActiveRecord::Migration[5.1]
  def change
    remove_column :solutions, :output, :text
  end
end
