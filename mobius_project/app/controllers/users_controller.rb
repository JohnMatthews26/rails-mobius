class UsersController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      render "users/index"
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  def index
    if current_user
      @users = User.all
    else
      redirect_to "users/new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
