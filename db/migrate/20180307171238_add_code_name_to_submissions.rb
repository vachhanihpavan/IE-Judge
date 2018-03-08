class AddCodeNameToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :code_name, :string
  end
end
