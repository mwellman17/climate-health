class RequireLabel < ActiveRecord::Migration[5.2]
  def change
    change_column :nodes, :label, :string, null: false
  end
end
