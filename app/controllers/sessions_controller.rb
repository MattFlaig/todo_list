class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = t("messages.login") 
      redirect_to todo_items_path
    else
      flash[:danger] = t("messages.login_failure")
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = t("messages.logout")
    redirect_to root_path
  end
end