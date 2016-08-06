class PostsController < ApplicationController
  before_action :ensure_author, only: [:edit, :update, :destroy]
  before_action :ensure_current_user, only: [:new, :create]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @comments = @post.master_comments
    render :show
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @sub = @post.sub
    @post.destroy
    redirect_to sub_url(@sub)
  end

  def edit
    @post = Post.find_by(id: params[:id])
    render :edit
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def ensure_author
    @post = Post.find_by(id: params[:id])
    unless current_user.id == @post.author_id
      flash[:errors] = "BAD BAD!!!!"
      redirect_to sub_url(@post.sub)
    end
  end


end#class
