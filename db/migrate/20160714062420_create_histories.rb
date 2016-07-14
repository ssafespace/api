class CreateHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :histories, id: :uuid do |table|
      table.uuid :topic_id, null: false, index: true
      table.uuid :host_id, null: false, index: true
      table.uuid :guest_id, null: false, index: true
      table.timestamps null: false, index: true
      table.index [:topic_id, :host_id, :guest_id], unique: true

      table.foreign_key :topics
      table.foreign_key :accounts, column: :host_id
      table.foreign_key :accounts, column: :guest_id
    end
  end
end
