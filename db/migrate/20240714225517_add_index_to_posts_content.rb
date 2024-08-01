class AddIndexToPostsContent < ActiveRecord::Migration[7.1]
  def change
    add_index :posts, :content
  end
end
