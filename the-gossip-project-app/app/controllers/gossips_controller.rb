class GossipsController < ApplicationController
  def show
    @gossip = Gossip.find(params[:id])
    @comments = @gossip.comments.includes(:user)
    @comment = Comment.new
  end
  def new
    @gossip = Gossip.new
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
    @gossip = Gossip.new(gossip_params)# 1) On récupère les données envoyées par le formulaire
    @gossip.user = User.first
    if @gossip.save# 2) On tente de sauvegarder en base de données
      flash[:notice] = "Potin créé avec succès !"
      redirect_to root_path # 3) Si succès → redirection vers la page show du potin créé
    else
      flash.now[:alert] = "Erreur : " + @gossip.errors.full_messages.join(", ")
      render :new # 4) Si échec → on réaffiche le formulaire avec les erreurs
    end
  end
  private
  def gossip_params # Strong parameters : sécurité Rails
    params.require(:gossip).permit(:title, :content)
  end
end
