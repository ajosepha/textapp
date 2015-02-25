require 'twilio-ruby'
require 'rufus-scheduler'

class NotificationsController < ApplicationController
 
  skip_before_action :verify_authenticity_token
 
  def index
    #check recipient is in databse of users
    user_sender = params[:From].slice(2..11)
    @user = User.find_by phone_number: user_sender
    puts @user.email
    puts params[:Body]
    @sender = params[:From]
    if params[:Body].downcase == "time"
      time_request
      elsif is_i?(params[:Body])
        puts "you entered a number"
        @time = params[:Body].to_i
        time_request  
      elsif params[:Body].downcase == "help"
        puts "let's get you out of there!"
      else
        puts "this is what gets hit when i get a message"
        create
    end
  end

  def is_i?(str)
    str.to_i.to_s == str
  end

  def test_message
    redirect_to :back
    @sender = "+1" + current_user.phone_number
    puts @sender.class
    puts @sender
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
      @client.account.messages.create(
        from: '+12054099140',
        to: @sender,
        body: "This is a test message from Ariel")   
  end

  def time_request
    puts "this will be a timed fcn"
    s = Rufus::Scheduler.singleton
    timex = (@time * 60).to_s + 's'
    s.in timex do
      @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
      @client.account.messages.create(
        from: '+12054099140',
        to: @sender,
        body: "Hi, can you call me? Know you're out, but it's really important :(")
    end        
  end

  def notify
    @client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = @client.messages.create from: '+12054099140', to: '+14154257945', body: 'Test message let for prosperity.', status_callback: request.base_url + '/twilio/status'
    render plain: message.status
  end

  def create
    sender = params[:From]
    puts sender
      @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
      @client.account.messages.create(
        from: '+12054099140',
        to: sender,
        body: "Thanks for the message. yay")   
  end
end