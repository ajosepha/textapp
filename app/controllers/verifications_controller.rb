class VerificationsController < ApplicationController

  before_filter :get_user

  def create
    @message = Message.create(:body=>params["Body"].downcase, :image=>params["MediaUrl"])

    @phone = params["phone"]

    @client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
  end
 
  private
  def get_user
    unless @user = User.find_by_phone(params['From'])
      head :not_found
    end
  end
 
end
end
