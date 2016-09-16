class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @user  = User.all
    @posts = Post.all
  end

  def add_friend
    @requested_freind =  User.find(params[:id])
    current_user.friend_request(@requested_freind)
    flash[:notice] = 'Friend requset sent succssfully'
    redirect_to :back
  end

  def accept_friend
    @requested_freind =  User.find(params[:id])
    current_user.accept_request(@requested_freind)
    flash[:notice] = 'Friend requset accept succssfully'
    redirect_to :back
  end

end
