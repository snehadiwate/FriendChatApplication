class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :post_title
      t.text :post_text
      t.integer :user_id
      t.boolean :visible

      t.timestamps null: false
    end
  end
end
