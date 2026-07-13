class Transaction < ApplicationRecord
  belongs_to :order
  has_one :payment, dependent: :destroy

  # enums
  enum status: {
    pending: 0,
    successful: 1,
    failed: 2
  }

  enum service:{
    paystack: 0
  }

  # --- Validations ---
  validates :email, presence: true
  validates :amount, presence: true
  validates :reference_code, presence: true
  validates :auth_url, presence: true
  validates :access_code, presence: true
end
