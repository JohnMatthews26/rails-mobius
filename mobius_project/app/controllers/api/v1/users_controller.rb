class Api::V1::UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
  end
end
