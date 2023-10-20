require 'cancancan'

class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  
 
  def show
    @user = User.find(params[:id]) 
  end

  

  def admin_board
    @messages=Message.all
    @reviews=Review.all
    @researches=Research.all
    @users=User.all
  end

def remove_mod
  @user = User.find(params[:id])
  @user.role=0
  @user.save
  redirect_to admin_board_path
end

  def set_mod
    @user = User.find(params[:id])
    @user.role=2
    @user.save
    redirect_to admin_board_path

  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "Utente eliminato con successo."
    else
      flash[:error] = "Impossibile eliminare l'utente."
    end
    if current_user.admin?
      redirect_to admin_board_path
    else
      redirect_to root_path
    end
  end

  def f_review
    @review = Review.find(params[:id])
  end


end


