module Paystack::Variables
  extend ActiveSupport::Concern

  def load_paystack_vars
    @paystack_url = ENV.fetch('PAYSTACK_BASE_URL')
    @paystack_secret_key = ENV.fetch('PAYSTACK_SECRET_KEY')
  end
end