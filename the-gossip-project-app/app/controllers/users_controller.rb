class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Bienvenue #{@user.first_name} ! Ton compte a été créé."
      redirect_to root_path
    else
      flash.now[:alert] = "Erreur : " + @user.errors.full_messages.join(", ")
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :city_id, :age, :email, :password, :password_confirmation)
  end
end
