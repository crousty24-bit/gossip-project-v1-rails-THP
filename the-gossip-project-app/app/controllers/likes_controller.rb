class LikesController < ApplicationController
  before_action :authenticate_user
  before_action :set_gossip

  def create
    @gossip.likes.find_or_create_by(user: current_user)
    redirect_back fallback_location: gossip_path(@gossip)
  end

  def destroy
    like = @gossip.likes.find_by(user: current_user)
    like.destroy if like
    redirect_back fallback_location: gossip_path(@gossip)
  end

  private

  def set_gossip
    @gossip = Gossip.find(params[:gossip_id])
  end
end
