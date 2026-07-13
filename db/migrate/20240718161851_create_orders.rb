class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.references :cart, null: false, foreign_key: true, type: :uuid
      t.integer :status

      t.timestamps
    end
  end
end
