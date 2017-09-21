class SessionsController < ApplicationController

  def new
    if logged_in?
      redirect_to "/users"
    end
  end
  
  def create

    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if @user || logged_in?
      login!(@user)
      redirect_to "/users"
    else
      render(
        json: ["Invalid username/password combination"],
        status: 401
        )
    end
  end

  def destroy
    @user = current_user
    if @user
      logout!
      render "users/new"
    else
      render(
        json: ["Nobody signed in"],
        status: 404
      )
    end
  end
end
