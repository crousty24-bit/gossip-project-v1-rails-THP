class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      # ✅ Gérer la checkbox
      if params[:remember_me] == "1"
        remember(user)  # crée cookie permanent
      else
        forget(user)    # supprime cookie si existant
      end

      redirect_to root_path
    else
      flash[:alert] = "Email ou mot de passe incorrect"
      render :new
    end
  end

  def destroy
    log_out(current_user)  # supprime session + cookie
    redirect_to root_path
  end
end