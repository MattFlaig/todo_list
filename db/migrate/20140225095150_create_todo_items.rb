class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      t.string :name
      t.string :content
      t.string :comment
      t.integer :status

      t.timestamps
    end
  end
end
