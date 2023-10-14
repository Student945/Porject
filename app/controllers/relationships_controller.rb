require 'cancancan'

class RelationshipsController < ApplicationController
  load_and_authorize_resource
  before_action :logged_in_user
  

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  
  def logged_in_user
    !current_user.nil?
  end
end
