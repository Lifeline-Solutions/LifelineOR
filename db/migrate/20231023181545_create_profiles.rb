class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :home_address
      t.string :phone_number
      t.string :occupation
      t.string :location
      t.string :avatar
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
