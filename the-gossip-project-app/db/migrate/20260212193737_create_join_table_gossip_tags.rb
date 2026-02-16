class CreateJoinTableGossipTags < ActiveRecord::Migration[8.0]
  def change
    create_table :join_table_gossip_tags do |t|
      t.belongs_to :gossip, null: false, foreign_key: true
      t.belongs_to :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
