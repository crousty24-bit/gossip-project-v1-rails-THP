class CommentsController < ApplicationController
  before_action :authenticate_user, only: [:create, :edit, :update, :destroy]
  def create
    @gossip = Gossip.find(params[:gossip_id]) #modifié
    @comment = @gossip.comments.new(comment_params)
    @comment.user = User.first

    if @comment.save
      flash[:notice] = "Commentaire ajouté"
      redirect_to gossip_path(@gossip)
    else
      flash.now[:alert] = "Erreur : " + @comment.errors.full_messages.join(", ")
      @comments = @gossip.comments.includes(:user)
      render "gossips/show"
    end
  end

  def edit
    @gossip  = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @gossip  = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      flash[:notice] = "Commentaire modifié avec succès !"
      redirect_to gossip_path(@gossip) #modifié
    else
      flash.now[:alert] = "Erreur : " + @comment.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @gossip  = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Commentaire supprimé avec succès !"
    redirect_to gossip_path(@gossip)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def authenticate_user
    unless current_user
      flash[:danger] = "Veuillez vous connecter"
      redirect_to new_session_path
  end
  end
end
