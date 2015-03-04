class VisitorsController < ApplicationController
  def index
    unless user_signed_in?
        redirect_to new_user_session_path
    else
        @post = Post.new 
    end
  end
end
