class CreateComparisonsRepositories < ActiveRecord::Migration
  def change
    create_table :comparisons_repositories do |t|
      t.references :comparison, foreign_key: true
      t.references :repository, foreign_key: true
    end

    add_index :comparisons_repositories, :comparison_id, using: :btree
    add_index :comparisons_repositories, :repository_id, using: :btree
    add_index :comparisons_repositories, [:comparison_id, :repository_id], name: :index_comparisons_repositories_keys, using: :btree
  end
end
