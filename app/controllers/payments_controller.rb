class PaymentsController < ApplicationController  
  skip_before_action :verify_authenticity_token

  def index  
  end 


  def create
    price = 120
    @payment=create_payment(params["nonce"],120)
    if @payment.success?
      flash.alert = "payment successful"
      redirect_to payments_path
    else
      flash.alert =["We couldn't process your transaction"]
      redirect_to payments_path
    end
  end

  private

  def get_square_client
    access_token = ENV['access_token']
    location_id = ENV['location_id']
    case Rails.env
    when"production"
      environment="production"
    else
      environment='sandbox'
    end
    client = Square::Client.new(
      access_token: access_token,
      environment: environment
    )
    return client
  end

  def create_payment(nonce, price)
    client=self.get_square_client
    location_id=ENV['location_id']
    result = client.payments.create_payment(
      body: {
        source_id: nonce,
        idempotency_key: SecureRandom.uuid(),
        amount_money: {
          amount: price,
          currency: "USD"
        },
        location_id: location_id
      }
    )
    return result
  end
end
