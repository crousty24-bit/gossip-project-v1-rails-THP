class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:create, :edit, :update, :show, :new, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  def show
    @gossip = Gossip.find(params[:id])
    @comments = @gossip.comments.includes(:user)
    @comment = Comment.new
  end
  def new
    @gossip = Gossip.new
    @tags = Tag.all
  end
  def edit
    @gossip = Gossip.find(params[:id])
  end
  def update
    @gossip = Gossip.find(params[:id])
    if @gossip.update(gossip_params)
      flash[:notice] = "Potin modifié avec succès !"
      redirect_to @gossip
    else
      flash.now[:alert] = "Erreur : " + @gossip.errors.full_messages.join(", ")
      render :edit
    end
  end
  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    flash[:notice] = "Potin supprimé avec succès !"
    redirect_to root_path
  end
  def create
    @gossip = current_user.gossips.create(gossip_params)
    if @gossip.save# 2) On tente de sauvegarder en base de données
      flash[:notice] = "Potin créé avec succès !"
      redirect_to root_path # 3) Si succès → redirection vers la page show du potin créé
    else
      @tags = Tag.all
      flash.now[:alert] = "Erreur : " + @gossip.errors.full_messages.join(", ")
      render :new # 4) Si échec → on réaffiche le formulaire avec les erreurs
    end
  end
  private
  def gossip_params # Strong parameters : sécurité Rails
    params.require(:gossip).permit(:title, :content, tag_ids: [])
  end
  def authenticate_user
    unless current_user
      flash[:danger] = "Veuillez vous connecter"
      redirect_to new_session_path
  end
  def authorize_user
    @gossip = Gossip.find(params[:id])
    redirect_to root_path unless @gossip.user == current_user
  end
end
end
