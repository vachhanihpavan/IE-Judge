class Solution < ApplicationRecord
  has_attached_file :submitted_code, :path => ":rails_root/public/codes/:attachment/:filename"
  do_not_validate_attachment_file_type :submitted_code

  belongs_to :user, optional: true

end
