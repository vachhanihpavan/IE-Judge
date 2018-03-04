class Problem < ApplicationRecord
  has_attached_file :correct_code, :path => ":rails_root/public/codes/:attachment/:filename"
  do_not_validate_attachment_file_type :correct_code, { validate_media_type: false }
  belongs_to :user, optional: true
end
