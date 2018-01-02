class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(name: params[:name].downcase)
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:error] = "Username or Password Incorrect"
      redirect_to "/login"
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

end
