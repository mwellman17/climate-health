class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.integer :upstream_node, null: false
      t.integer :downstream_node, null: false
      t.integer :value, default: 5

      t.timestamps
    end
  end
end
