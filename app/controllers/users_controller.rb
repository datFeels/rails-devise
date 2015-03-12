class UsersController < ApplicationController
  before_filter :authenticate_user!


  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end

  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  def like
      if params[:likeable_type] == "Post"
          @likeable = Post.find(params[:likeable_id])
      else
          @likeable = Comment.find(params[:likeable_id])
      end
	  current_user.like!(@likeable)
  	respond_to do |format|
        format.json { render json: { likes: @likeable.likers(User).count } }
    end
  end
  
  def unlike
      if params[:likeable_type] == "Post"
          @likeable = Post.find(params[:likeable_id])
      else
          @likeable = Comment.find(params[:likeable_id])
      end
  	current_user.unlike!(@likeable)
	  respond_to do |format|
        format.json { render json: { likes: @likeable.likers(User).count } }
    end
  end

  private

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def secure_params
    params.require(:user).permit(:role)
  end

end
