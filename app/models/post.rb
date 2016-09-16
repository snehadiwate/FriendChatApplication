# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  post_title :string
#  post_text  :text
#  user_id    :integer
#  visible    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  
  has_attached_file :upload
  
  do_not_validate_attachment_file_type :upload
 
  #include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url(:original),
      "delete_url" => upload_path(self),
      "delete_type" => "DELETE",
      "is_invoice" => self.is_invoice
    }
  end
end
