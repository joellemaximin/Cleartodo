class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.integer :user_id
      t.string :content
      t.boolean :completed, default: false
      t.timestamps
    end
  end
end
