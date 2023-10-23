class CreateConsultations < ActiveRecord::Migration[7.0]
  def change
    create_table :consultations, id: :uuid do |t|
      t.string :title
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
