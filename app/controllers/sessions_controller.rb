class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      login_user!(@user)
    else
      flash.now[:errors] = ["Couldn't find user with those credentials"]
      render :new
    end
  end

  def destroy
    logout_user!
  end
end
