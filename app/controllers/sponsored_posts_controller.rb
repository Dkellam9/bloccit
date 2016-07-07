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
end
