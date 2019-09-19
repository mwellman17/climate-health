class CreateNodeTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :node_topics do |t|
      t.belongs_to :node
      t.belongs_to :topic

      t.timestamps
    end
  end
end
