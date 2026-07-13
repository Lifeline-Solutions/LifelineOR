class Payment < ApplicationRecord
  # associations
  belongs_to :transaction

  # enums
  enum status: {
    pending: 0,
    successful: 1,
    failed: 2
  }

  # --- Validations ---
  validates :amount, presence: true
  validates :channel, presence: true
  validates :currency, presence: true
  validates :reference_code, presence: true
  validates :receipt_number, presence: true
end
