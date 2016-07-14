class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages, id: :uuid do |table|
      table.text :body, null: false, index: true
      table.uuid :history_id, null: false, index: true
      table.uuid :account_id, null: false, index: true
      table.timestamps null: false, index: true

      table.foreign_key :accounts
      table.foreign_key :histories
    end
  end
end
