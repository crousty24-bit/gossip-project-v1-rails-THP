class CommentsController < ApplicationController
  def create
  @gossip = Gossip.find(params[:id])
  @comment = @gossip.comments.new(comment_params)
  @comment.user = User.first
    if @comment.save
      flash[:notice] = "Commentaire ajouté"
      redirect_to gossip_path
    else
      flash.now[:alert] = "Erreur : " + @gossip.errors.full_messages.join(", ")
      render :new
    end
  end
  def edit
  @gossip = Gossip.find(params[:id])
  @comment = Comment.find(params[:id])
  end
  def update
  @gossip = Gossip.find(params[:id])
  @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = "Commentaire modifié avec succès !"
      redirect_to @gossip
    else
      flash.now[:alert] = "Erreur : " + @gossip.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Commentaire supprimé avec succès !"
    redirect_to gossip_path
  end
end
