class CommentLikesController < ApplicationController
  before_action :authenticate_user
  before_action :set_comment

def create
  @comment.likes.find_or_create_by(user: current_user)
  redirect_back fallback_location: gossip_path(@comment.commentable)
end

def destroy
  like = @comment.likes.find_by(user: current_user)
  like.destroy if like
  redirect_back fallback_location: gossip_path(@comment.commentable)
end


  private

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end
end
