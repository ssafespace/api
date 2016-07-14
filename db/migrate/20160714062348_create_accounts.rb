class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts, id: :uuid do |table|
      table.text :phone, null: false, index: {unique: true}
      table.text :secret

      table.timestamps null: false, index: true
    end
  end
end
