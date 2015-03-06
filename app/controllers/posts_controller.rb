class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :new, :edit, :destroy]

  respond_to :html

  def index

    unless user_signed_in?
        redirect_to new_user_session_path
    else
        @post = Post.new 
        @posts = Post.all
        @user = User.all
        
    respond_with(@posts)
    
    end
  end

  def show
   @post = Post.find(params[:id])
   @post_attachments = @post.post_attachments.all
   
    respond_to do |format|
       format.html # show.html.erb
       format.js
    end
  end

  def new
    @post = Post.new
    respond_with(@post)
    @post_attachment = @post.post_attachments.build       
    
        respond_to do |format|
            format.html # new.html.erb
            format.js
        end
    
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    respond_to do |format|
       if @post.save 
         
         params[:post_attachments]['picture'].each do |a|
            @post_attachment = @post.post_attachments.create!(:picture => a, :post_id => @post.id)
         end
         format.html { redirect_to @post, notice: 'Post was successfully created.' }
         format.js
       else
         format.html { render action: 'new' }
         format.js
         render 'new'
       end
    end
  end

  def update
    @post.update(post_params)
    respond_with(@post)
        respond_to do |format|
            if @post.update_attributes(params[:post])
                format.html { redirect_to @post, notice: 'Post was successfully updated.' }
                format.js
            else
                format.html { render action: "edit" }
                format.js
            end
        end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_with(@post)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:user_id, :title, :content, post_attachments_attributes: [:id, :post_id, :picture])
    end
end

