class CreateComparisons < ActiveRecord::Migration
  def change
    create_table :comparisons do |t|
      t.string  :code,             null: false
      t.integer :executions_count, null: false, default: 0

      t.timestamps null: false
    end

    add_index :comparisons, :code, unique: true, using: :btree
  end
end
