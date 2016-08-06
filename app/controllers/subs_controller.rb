class SubsController < ApplicationController
  before_action :ensure_moderator, only: [:edit, :update, :destroy]
  before_action :ensure_current_user, only: [:new, :create]

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    @posts = @sub.posts
    render :show
  end

  def destroy
    @sub = Sub.find_by(id: params[:id])
    @sub.destroy
    redirect_to subs_url
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
    render :edit
  end

  def update
    @sub = Sub.find_by(id: params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def ensure_moderator
    @sub = Sub.find_by(id: params[:id])
    unless current_user.id == @sub.moderator_id
      flash[:errors] = "BAD BAD!!!!"
      redirect_to subs_url
    end
  end
end
