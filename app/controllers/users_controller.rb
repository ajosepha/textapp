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
