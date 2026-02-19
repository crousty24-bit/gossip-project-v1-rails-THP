class HomeController < ApplicationController
  def index
    @gossips = Gossip.all
    @first_name = current_user&.first_name
  end
end
