class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  include SessionsHelper
  def authenticate_user
    unless current_user
      flash[:danger] = "Veuillez vous connecter"
      redirect_to new_session_path
    end
  end
end
