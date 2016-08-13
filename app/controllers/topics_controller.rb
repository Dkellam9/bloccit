class TopicsController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show, :edit, :update]
  
  def index
    @topics = Topic.all
  end
  
  def show
     @topic = Topic.find(params[:id])
  end
  
  def new
     @topic = Topic.new
  end  
  
  def create
    @topic = Topic.new(topic_params)
 
    if @topic.save
      flash[:notice] = "Topic was saved successfully."
      redirect_to @topic
    else
      flash.now[:alert] = "Error creating topic. Please try again."
      render :new
    end
  end
  
  def edit
    if current_user.moderator? || current_user.admin?
    then @topic = Topic.find(params[:id])
    else
      "You need to be an Admin or Moderator to do that."
    end
  end
  
  def update
    if current_user.moderator? || current_user.admin?
    then
      @topic = Topic.find(params[:id])
 
      @topic.name = params[:topic][:name]
      @topic.description = params[:topic][:description]
      @topic.public = params[:topic][:public]
    else
      "You need to be an Admin or Moderator to do that."
    end
 
    if @topic.save
      flash[:notice] = "Topic was updated successfully."
      redirect_to @topic
    else
      flash.now[:alert] = "Error saving topic. Please try again."
      render :edit
    end
  end
  
  def destroy
    @topic = Topic.find(params[:id])
 
    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the topic."
      render :show
    end
  end
  private
 
  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end
  
  def authorize_user
     unless current_user.admin?
       flash[:alert] = "You must be an Admin to do that."
       redirect_to topics_path
     end
  end
end
