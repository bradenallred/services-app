class ReviewsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @review = @post.reviews.build(review_params.merge(user: current_user))
    if @review.save
      redirect_to @post, notice: 'Review added successfully.'
    else
      redirect_to @post, alert: 'Error adding review.'
    end
  end
  
  private
  
  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
