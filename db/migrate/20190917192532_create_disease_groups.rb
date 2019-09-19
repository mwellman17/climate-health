class CreateDiseaseGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :disease_groups do |t|
      t.belongs_to :node
      t.belongs_to :disease

      t.timestamps
    end
  end
end
