class CreatePatientGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :patient_groups do |t|
      t.belongs_to :node
      t.belongs_to :patient

      t.timestamps
    end
  end
end
