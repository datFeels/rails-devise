class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :new, :edit, :destroy]

  respond_to :html

  def index

    unless user_signed_in?
        redirect_to new_user_session_path
    else
        @post = Post.new 
        @posts = Post.all
        
    respond_with(@posts)
    end
  end

  def show
   @post = Post.find(params[:id])
   @user = User.find(params[:id])
  end

  def new
    @post = Post.new
    respond_with(@post)
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.save
    respond_with(@post)
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post.destroy
    respond_with(@post)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:user_id, :title, :content)
    end
end
