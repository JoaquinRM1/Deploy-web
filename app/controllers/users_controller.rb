class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to root_path, alert: "User not found"
    else
      @posts = @user.posts
      @comments = @user.comments
    end
  end
end
