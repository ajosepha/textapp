require 'twilio-ruby'

class NotificationsController < ApplicationController
 
  skip_before_action :verify_authenticity_token
 
  def index

  end

  def notify
    @client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = @client.messages.create from: '+12054099140', to: '+14154257945', body: 'Test message let for prosperity.', status_callback: request.base_url + '/twilio/status'
    render plain: message.status
  end

  def receive_msg
  #    @client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
  #    @user = User.find(params[:phone_numer])
  # name = friends[sender] || "Mobile Monkey"
  twiml = Twilio::TwiML::Response.new do |r|
    r.Message "Hello, you. Thanks for the message."
  end
  twiml.text
  end
end