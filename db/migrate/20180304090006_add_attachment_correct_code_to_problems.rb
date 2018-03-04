class AddAttachmentCorrectCodeToProblems < ActiveRecord::Migration[5.1]
  def self.up
    change_table :problems do |t|
      t.attachment :correct_code
    end
  end

  def self.down
    remove_attachment :problems, :correct_code
  end
end
