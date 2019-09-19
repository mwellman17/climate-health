class ChangeLinks < ActiveRecord::Migration[5.2]
  def up
    change_column :links, :upstream_node, :string, null: false
    change_column :links, :downstream_node, :string, null: false
  end

  def down
    change_column :links, :upstream_node, 'integer USING CAST(upstream_node AS integer)', null: false
    change_column :links, :downstream_node, 'integer USING CAST(downstream_node AS integer)', null: false
  end
end
