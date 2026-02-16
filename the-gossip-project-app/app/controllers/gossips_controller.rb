class GossipsController < ApplicationController
  def index
    @gossips = Gossip.all
    render 'home/index'
  end

  
  def show
  @gossip = Gossip.find(params[:id])
  end
end
