class CreateSolutions < ActiveRecord::Migration[5.1]
  def change
    create_table :solutions do |t|
      t.bigint :submitted_by
      t.datetime :submitted_time
      t.string :language
      t.bigint :problem_id
      t.text :output
      t.string :result

      t.timestamps
    end
  end
end
