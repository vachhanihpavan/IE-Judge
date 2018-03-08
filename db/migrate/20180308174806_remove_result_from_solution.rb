class RemoveResultFromSolution < ActiveRecord::Migration[5.1]
  def change
    remove_column :solutions, :result, :string
  end
end
