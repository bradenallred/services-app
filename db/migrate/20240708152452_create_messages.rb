class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :sender_id
      t.integer :receiver_id

      t.timestamps
    end

    add_foreign_key :messages, :users, column: :sender_id
    add_foreign_key :messages, :users, column: :receiver_id
    add_index :messages, :sender_id
    add_index :messages, :receiver_id
  end
end