class PostsController < ApplicationController
  before_action :require_sign_in, except: :show
  before_action :authorize_user, except: [:show, :new, :create, :edit, :update]
  
  def show
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end
  
  def create
    if current_user.member? || current_user.moderator? || current_user.admin?
    then
      @post = Post.new
      @post.title = params[:post][:title]
      @post.body = params[:post][:body]
      @topic = Topic.find(params[:topic_id])
      @post.topic = @topic
      
      @post.user = current_user
    else
      "You must be a member to do that."
    end
    
    if @post.save
      flash[:notice] = "Post was saved successfully."
      redirect_to [@topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    post = Post.find(params[:id])
    if current_user == post.user || current_user.moderator? || current_user.admin?
    then @post = Post.find(params[:id])
    else
      "You need to be OP or an Admin or Moderator to do that."
    end
  end
  
  def update
    post = Post.find(params[:id])
    if current_user == post.user || current_user.moderator? || current_user.admin?
    then
      @post = Post.find(params[:id])
      @post.title = params[:post][:title]
      @post.body = params[:post][:body]
    else
      "You need to be OP or an Admin or Moderator to do that."
    end
     
    if @post.save
      flash[:notice] = "Post was updated successfully."
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end
  
  def destroy
     @post = Post.find(params[:id])
     
     if @post.destroy
       flash[:notice] = "\"#{@post.title}\" was deleted successfully."
       redirect_to @post.topic
     else
       flash.now[:alert] = "There was an error deleting the post."
       render :show
     end
  end
  
  private
 
  def post_params
    params.require(:post).permit(:title, :body)
  end
  
  def authorize_user
     post = Post.find(params[:id])
     unless current_user == post.user || current_user.admin?
       flash[:alert] = "You must be an admin to do that."
       redirect_to [post.topic, post]
     end
  end

end
