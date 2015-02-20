require 'twilio-ruby'

class NotificationsController < ApplicationController
 
  skip_before_action :verify_authenticity_token
 
  def index
    puts params[:From]
    puts params[:Body]
    @sender = params[:From]
    if params[:Body].downcase == "time"
      time_request
    else
      puts "this is what gets hit when i get a message"
      create
    end
  end

  def test_message
    # render :nothing => true
    redirect_to :back
    @sender = "+1" + current_user.phone_number
    puts @sender.class
    puts @sender
    @client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
      @client.account.messages.create(
        from: '+12054099140',
        to: @sender,
        body: "This is a test message")   
  end

  def time_request
     @client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
      @client.account.messages.create(
        from: '+12054099140',
        to: @sender,
        body: "Great, what time is your date?")   
  end

  def notify
    @client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = @client.messages.create from: '+12054099140', to: '+14154257945', body: 'Test message let for prosperity.', status_callback: request.base_url + '/twilio/status'
    render plain: message.status
  end

  def create
    sender = params[:From]
    puts sender
      @client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
      @client.account.messages.create(
        from: '+12054099140',
        to: sender,
        body: "Thanks for siginging up. yay")   
  end
end