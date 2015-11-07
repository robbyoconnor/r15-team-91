class CreateRepository < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :owner, null: false
      t.string :name,  null: false

      t.timestamps null:false
    end

    add_index :repositories, [:owner, :name], unique: true
  end
end
