# -*- encoding : utf-8 -*-
class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body
      t.references :user
      t.references :topic

      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, :topic_id
  end
end
