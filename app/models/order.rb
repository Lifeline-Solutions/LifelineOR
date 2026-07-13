class Order < ApplicationRecord
  # associations
  belongs_to :cart
  before_validation :generate_tracking_number

  # validations
  validates :cart_id, presence: true, uniqueness: true
  validates :tracking_number, presence: true, uniqueness: true

  private

  def generate_tracking_number
    random_part = SecureRandom.alphanumeric(6).upcase
    self.tracking_number = "LFL#{random_part}"
  end
end
