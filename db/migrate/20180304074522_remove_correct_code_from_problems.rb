class RemoveCorrectCodeFromProblems < ActiveRecord::Migration[5.1]
  def change
    remove_column :problems, :correct_code, :text
  end
end
