class Api::UsersController < ApplicationController
  def index
    p "Hello"
    @client_token = generate_client_token
    render :action => :index

    #put paypal here
    # ping paypal, paste in their code
    # p out stuff to verify that it's working
  end

  def new
    @client_token = generate_client_token
  end

  def create
    p "In create"
    p "params: #{params}"

    user = User.new({:email => params[:email]})
    user.save

    p "user id: #{user.id}"

    result = Braintree::Customer.create(
      :email => params[:email],
      :id => user.id,
      :payment_method_nonce => params[:payment_method_nonce]
    )

    p "result: #{result}"
    render "api/users/thank_you"

  end

  def charge
    p "In charge: params: #{params}"

    result = Braintree::Transaction.sale(
      :amount => ".01",
      :customer_id => params[:id],
      :options => {
          :submit_for_settlement => true
      }
    )
  end

  def reward 
    p "******* In reward *******"

    require 'net/http'
    require "addressable/uri"

    query_uri = Addressable::URI.new
    query_uri.query_values =  { 
            'access_token' => 'kHc6Gzx7qX7aT6C2z3pkBQ396UdGxS3B',
            'phone' => '5103043300',
            'amount' => "1",
            'note' => "for saving power!"
    }

    uri = URI.parse("https://api.venmo.com/v1/payments")
    http = Net::HTTP.new(uri.host, '80')

    p "uri: #{uri}, port: #{uri.port}"

    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new("/v1.1/auth")
    request.add_field('Content-Type', 'application/x-www-form-urlencoded')
    request.body = query_uri.query

    p "body: #{request.body}"

    p "request: #{request}"

    response = http.request(request)

    p "response: #{response}"

  end


  private
  def generate_client_token
    Braintree::ClientToken.generate
  end
end

