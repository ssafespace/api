class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations, id: :uuid do |table|
      table.text :latitude, null: false, index: true
      table.text :longitude, null: false, index: true
      table.uuid :history_id, null: false, index: true
      table.uuid :account_id, null: false, index: true
      table.timestamps null: false, index: true

      table.foreign_key :histories
      table.foreign_key :accounts
    end
  end
end
