class CommentsController < ApplicationController
  def new

  end

  def create
    @comment = Post.find(params[:post_id]).comments.new(comment_params)
    @comment.save

    redirect_to "/posts/#{params[:id]}"
  end


  def comment_params
      params.permit(:content)
  end

end
