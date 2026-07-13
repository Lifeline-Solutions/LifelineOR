class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments, id: :uuid do |t|
      t.references :transaction, null: false, foreign_key: true, type: :uuid
      t.string :reference_code
      t.string :channel
      t.string :currency
      t.string :amount
      t.string :receipt_number
      t.string :brand
      t.string :card_type
      t.string :bank
      t.string :mobile_money_number
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
