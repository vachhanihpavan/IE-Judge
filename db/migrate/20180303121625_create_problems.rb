class CreateProblems < ActiveRecord::Migration[5.1]
  def change
    create_table :problems do |t|
      t.string :title
      t.text :description
      t.text :testcases
      t.text :input
      t.text :correct_output
      t.text :correct_code

      t.timestamps
    end
  end
end
