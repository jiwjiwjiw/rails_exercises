class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_or_create_by(user_params)
    user.save!
    redirect_to ideas_path
  end

  def user_params
    params.permit(:email)
  end

end
