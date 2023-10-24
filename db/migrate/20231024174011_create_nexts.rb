class CreateNexts < ActiveRecord::Migration[7.0]
  def change
    create_table :nexts, id: :uuid do |t|
      t.string :name
      t.string :relationship
      t.string :phone_number
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end