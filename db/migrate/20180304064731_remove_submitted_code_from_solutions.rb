class RemoveSubmittedCodeFromSolutions < ActiveRecord::Migration[5.1]
  def change
    remove_column :solutions, :submitted_code, :text
  end
end
