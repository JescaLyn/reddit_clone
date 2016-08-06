class CommentsController < ApplicationController
  def new
    @post = Post.find_by(id: params[:post_id])
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find_by(id: params[:post_id])
    @comment.author_id = current_user.id

    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find_by(id: params[:id])
    render :show
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
