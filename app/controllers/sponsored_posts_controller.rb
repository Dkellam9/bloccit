class SponsoredPostsController < ApplicationController
  def show
    @sponsoredpost = SponsoredPost.find(params[:id])
  end

  def new
    @sponsoredpost = SponsoredPost.new
  end
  
  def create
     @sponsoredpost = Post.new
     @sponsoredpost.title = params[:sponsoredpost][:title]
     @sponsoredpost.body = params[:sponsoredpost][:body]
     @sponsoredpost.price = params[:sponsoredpost][:price]

     if @sponsoredpost.save
       flash[:notice] = "Sponsored post was saved successfully."
       redirect_to @sponsoredpost
     else
       flash.now[:alert] = "There was an error saving the sponsored post. Please try again."
       render :new
     end
  end

  def edit
    @sponsoredpost = Post.find(params[:id])
  end
  
  def update
    @sponsoredpost = SponsoredPost.find(params[:id])
    @sponsoredpost.title = params[:post][:title]
    @sponsoredpost.body = params[:post][:body]
    @sponsoredpost.price = params[:sponsoredpost][:price]
    
    if @sponsoredpost.save
      flash[:notice] = "Sponsored post was updated successfully."
      redirect_to [@sponsoredpost.topic, @sponsoredpost]
    else
      flash.now[:alert] = "There was an error saving the sponsored post. Please try again."
      render :edit
    end
  end

  def destroy
    @sponsoredpost = SponsoredPost.find(params[:id])
    if @sponsoredpost.destroy
      flash[:notice] = "\"#{@sponsoredpost.title}\" was deleted successfully."
      redirect_to @sponsoredpost.topic
    else
      flash.now[:alert] = "There was an error deleting the sponsored post."
      render :show
    end
  end
end
