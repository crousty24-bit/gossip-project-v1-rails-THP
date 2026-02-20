class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      if params[:remember_me] == "1"
        remember(user)  
      else
        forget(user)    
      end

      redirect_to root_path
    else
      flash[:alert] = "Email ou mot de passe incorrect"
      render :new
    end
  end

  def destroy
    log_out(current_user)  
    redirect_to root_path
  end
end