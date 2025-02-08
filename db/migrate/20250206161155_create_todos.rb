class CreateTodos < ActiveRecord::Migration[8.0]
  def change
    create_table :todos do |t|
      t.belongs_to :project, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.integer :user_id
      t.date :due_date
      t.boolean :completed, default: false
      t.integer :position

      t.timestamps
    end
  end
end
