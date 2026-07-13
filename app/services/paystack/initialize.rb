class Paystack::Transactions::Initialize < ApplicationService
  include Paystack::Variables

  attr_reader :args, :errors, :email, :amount, :paystack_url, :paystack_secret_key, :response, :order_id, :order, :user_id, :transaction, :tip

  def initialize(args)
    super

    @args = args
    @errors = []
    @email = args[:email]
    @order_id = args[:order_id]
    @user_id = args[:user_id]
    @tip = args[:tip]
  end

  def call
    logger.info "[Service] Paystack::Transactions::Initialize called"

    begin
      find_order
      load_paystack_vars
      initialize_transaction
      create_transaction
      results
    rescue RestClient::ExceptionWithResponse => e
      handle_rest_client_exception(e)
    rescue RestClient::RequestTimeout => e
      handle_timeout_exception
    end
  end

  private

  def find_order
    logger.info "Finding order with id #{order_id}"

    @order = Order.find(order_id)

    if order.present?
      logger.info "Found order - #{order.title}"
      # multiply by 100 to convert to kobo
      @amount = order.total * 100
      return true
    end

    errors << "Order not found"
    false
  end

  def initialize_transaction
    return unless order.present?
    logger.info "Initializing Paystack transaction for #{email} with amount #{amount}"

    @response = RestClient.post "#{paystack_url}/transaction/initialize",
      {
        email: email,
        amount: amount,
      },
      {
        Authorization: "Bearer #{paystack_secret_key}"
      }
  end

  def create_transaction
    return unless response.code == 200

    logger.info "Creating transaction for #{email} with amount #{amount}"
    response_data = JSON.parse(response.body)["data"]

    transaction = Transaction.new(
      email: email,
      order_id: order.id,
      reference_code: response_data["reference"],
      auth_url: response_data["authorization_url"],
      access_code: response_data["access_code"],
      amount: order.price,
      service: 'paystack'
    )

    if transaction.save
      logger.info "Transaction created successfully"
      @transaction = transaction
    else
      errors = transaction.errors.full_messages
      logger.error "Transaction not created - #{errors}"
    end
  end


  def results
    return unless response.present? && transaction.present?
    logger.info "Processing results"

    if response.code == 200
      transaction.update(status: "successful")
      Result.new(
        success: true,
        model: JSON.parse(response.body)
      )
    else
      transaction.update(status: "failed")
      errors << response.body
      Result.new(
        success: false,
        errors: errors
      )
    end
  end

  def handle_rest_client_exception(exception)
    logger.error "RestClient exception: #{exception.message}"
    errors << exception.message
    Result.new(success: false, errors: errors)
  end

  def handle_timeout_exception
    logger.error "RestClient Timeout Exception: The request timed out"
    errors << "The request timed out"
    Result.new(success: false, errors: errors)
  end

end