class GossipsController < ApplicationController
  def show
    @gossip = Gossip.find(params[:id])
  end
  def new
  end
  def create
    @gossip = Gossip.new(gossip_params)# 1) On récupère les données envoyées par le formulaire
    if @gossip.save# 2) On tente de sauvegarder en base de données
      redirect_to gossip_path(@gossip), notice: "Potin créé avec succès !"# 3) Si succès → redirection vers la page show du potin créé
    else
      render :new # 4) Si échec → on réaffiche le formulaire avec les erreurs
    end
  end
  private
  def gossip_params # Strong parameters : sécurité Rails
    params.require(:gossip).permit(:title, :content)
  end
end
