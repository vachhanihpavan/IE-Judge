class CreateSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :submissions do |t|
      t.bigint :solution_id
      t.string :result
      t.text :output

      t.timestamps
    end
  end
end
