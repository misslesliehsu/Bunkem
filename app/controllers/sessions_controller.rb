class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]


  def new
  end

  def create
    @user = User.find_by(name: params[:name])
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
