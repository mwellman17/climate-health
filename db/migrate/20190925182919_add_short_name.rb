class AddShortName < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :label, :string
  end
end
