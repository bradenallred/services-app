class AddJobDetailsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :job_title, :string
    add_column :posts, :job_description, :text
  end
end
