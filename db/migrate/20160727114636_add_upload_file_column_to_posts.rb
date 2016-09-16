class AddUploadFileColumnToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :upload_file_name, :string
    add_column :posts, :upload_content_type, :string
    add_column :posts, :upload_file_size, :integer
  end

  def self.down
    remove_column :posts, :upload_file_name
    remove_column :posts, :upload_content_type
    remove_column :posts, :upload_file_size
  end
end
