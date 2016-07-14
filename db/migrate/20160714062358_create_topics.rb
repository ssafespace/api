class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics, id: :uuid do |table|
      table.string :name, null: false, index: {unique: true}

      table.timestamps null: false, index: true
    end
  end
end
