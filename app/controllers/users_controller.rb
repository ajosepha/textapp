class UsersController < ApplicationController
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to :action => :index
      @client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
      @client.account.sms.messages.create(
        from: '+12054099140',
        to: @user.number,
        body: "Thanks for siginging up. To verify your account, please type y. Standard messaging rates apply")

    else
      render 'new'
    end
  end

  def index
  end

  private
  def user_params
    params.require(:user).permit(:name, :number)
  end
end
