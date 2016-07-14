class CreateReceipts < ActiveRecord::Migration[5.0]
  def change
    create_table :receipts, id: :uuid do |table|
      table.uuid :history_id, null: false, index: true
      table.uuid :message_id, null: false, index: {unique: true}
      table.uuid :account_id, null: false, index: true
      table.timestamps null: false, index: true

      table.index [:history_id, :message_id, :account_id], unique: true
      table.foreign_key :histories
      table.foreign_key :messages
      table.foreign_key :accounts
    end
  end
end
