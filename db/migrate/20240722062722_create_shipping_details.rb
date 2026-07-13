class CreateShippingDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_details, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :first_name
      t.string :last_name
      t.string :phone_number_1
      t.string :phone_number_2
      t.string :address
      t.string :additional_info
      t.string :region
      t.string :city

      t.timestamps
    end
  end
end
