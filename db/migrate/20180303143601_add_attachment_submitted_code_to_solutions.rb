class AddAttachmentSubmittedCodeToSolutions < ActiveRecord::Migration[5.1]
  def self.up
    change_table :solutions do |t|
      t.attachment :submitted_code
    end
  end

  def self.down
    remove_attachment :solutions, :submitted_code
  end
end
