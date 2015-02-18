require 'twilio-ruby'

class NotificationsController < ApplicationController
 
  skip_before_action :verify_authenticity_token
 
  def index
    puts params[:from]
    puts params
    puts "this is what gets hit when i get a message"
    create
  end

  def show
  end

  def notify
    @client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = @client.messages.create from: '+12054099140', to: '+14154257945', body: 'Test message let for prosperity.', status_callback: request.base_url + '/twilio/status'
    render plain: message.status
  end

  def create
    # skip_before_filter :verify_authenticity_token, :if =>lambda{ params[:api_key].present?}
    sender = params[:From]
    puts sender
      @client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
      @client.account.messages.create(
        from: '+12054099140',
        to: sender,
        body: "Thanks for siginging up. yay")

  # @client = Twilio::REST::Client.new  @client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
      
  end

  def receive_msg
  
  end
end