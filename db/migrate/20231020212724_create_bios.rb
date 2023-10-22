class CreateBios < ActiveRecord::Migration[7.0]
  def change
    create_table :bios, id: :uuid do |t|
      t.date :date_of_birth
      t.string :language
      t.string :home_town
      t.string :city
      t.string :country
      t.string :about_me
      t.string :health_insurance
      t.string :nhif_number
      t.string :nationality
      t.string :religion
      t.string :blood_group
      t.string :hospital_to_attend
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
