require 'twilio-ruby'

class NotificationsController < ApplicationController
 
  skip_before_action :verify_authenticity_token
 
  def notify
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: '+12054099140', to: '+14154257945', body: 'Test message.'
    render plain: message.status
  end
 
end