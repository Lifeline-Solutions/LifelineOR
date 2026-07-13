class Paystack::Transactions::Verify < ApplicationService
  include Paystack::PaystackVariables

  attr_reader :args, :reference, :paystack_url, :paystack_secret_key, :response, :payment, :transaction, :response_data

  def initialize(args)
    super

    @args = args
    @reference = args[:reference]
  end

  def call
    logger.info "[Service] Paystack::Transactions::Verify called"

    load_paystack_vars
    verify_transaction
    find_transaction
    create_payment
    update_payment_status
    results
  end

  private

  def verify_transaction
    logger.info "Verifying Paystack transaction with reference #{reference}"

    @response = RestClient.get "#{paystack_url}/transaction/verify/#{reference}",
      {
        Authorization: "Bearer #{paystack_secret_key}"
      }
    @response_data = JSON.parse(response.body)["data"]
  end

  def find_transaction
    reference = response_data["reference"]
    logger.info "Finding transaction with reference #{reference}"
    @transaction = PaystackTransaction.find_by(reference_code: reference)

    if transaction.present?
      logger.info "Found transaction - #{transaction.reference_code}"
      return true
    end

    errors << "Transaction not found"
    false
  end

  def create_payment
    return unless response.code == 200 && transaction.present?

    logger.info "Creating payment for #{transaction.email} with amount #{transaction.amount}"

    @payment = PaystackPayment.new(
      paystack_transaction: transaction,
      reference_code: response_data["reference"],
      channel: response_data["channel"],
      currency: response_data["currency"],
      amount: response_data["amount"] / 100,
      receipt_number: response_data["receipt_number"] ? response_data["receipt_number"] : generate_receipt_number,
      brand: response_data["authorization"]["brand"],
      card_type: response_data["authorization"]["card_type"],
      bank: response_data["authorization"]["bank"],
      mobile_money_number: response_data["authorization"]["mobile_money_number"]
    )

    if payment.save
      logger.info "Payment created for #{transaction.email} with amount #{transaction.amount}"
    else
      errors = payment.errors.full_messages
      logger.info "Payment not created for #{transaction.email} - #{errors}"
      errors <<  errors
    end
  end

  def update_payment_status
    return unless transaction.present? && payment.present?

    logger.info "Updating transaction and payment status for #{transaction.email} with amount #{transaction.amount}"

    status = response_data["status"]

    if status == "success"
      payment.update(status: :successful)
    else
      payment.update(status: :failed)
    end
  end

  def generate_receipt_number
    number = SecureRandom.alphanumeric(10).upcase.prepend("SE-RCT")
    if PaystackPayment.find_by(receipt_number: number).present?
      generate_receipt_number
    end
    number
  end


  def results
    return unless response.present? && transaction.present? && payment.present?
    logger.info "Processing results"

    if response.code == 200
      Result.new(
        success: true,
        model: JSON.parse(response.body)
      )
    else
      errors << response.body
      Result.new(
        success: false,
        errors: errors
      )
    end
  end

end