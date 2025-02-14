class PagesController < ApplicationController
  allow_unauthenticated_access only: :home
  before_action :set_user, only: :update_user_bio
  def home
    redirect_to dashboard_path if authenticated?
  end

  def dashboard
    @user = Current.user
    redirect_to root_path unless authenticated?
  end

  def update_user_bio
    if @user.update(user_params)
      redirect_to dashboard_path
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def user_params
    params.require(:user).permit(:bio)
  end
end
