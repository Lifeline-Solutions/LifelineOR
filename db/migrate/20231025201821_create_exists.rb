class CreateExists < ActiveRecord::Migration[7.0]
  def change
    create_table :exists, id: :uuid do |t|
      t.string :condition
      t.boolean :private
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
