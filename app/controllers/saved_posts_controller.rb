class SavedPostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    current_user.saved_posts.create(post: @post)
    redirect_to request.referrer, notice: "Post saved successfully."
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_user.saved_posts.find_by(post_id: @post.id).destroy
    redirect_to request.referrer, notice: "Post unsaved successfully."
  end
end
