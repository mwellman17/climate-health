class CreateNodes < ActiveRecord::Migration[5.2]
  def change
    create_table :nodes do |t|
      t.string :name, null: false
      t.belongs_to :category

      t.timestamps
    end
  end
end
