require 'rails_helper'
include RandomData

RSpec.describe SponsoredPostsController, type: :controller do
  let (:my_sponsoredpost) do
    SponsoredPost.create(
      id: 1,
      title: RandomData.random_sentence,
      body: RandomData.random_paragraph,
      price: 99
      )
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_sponsoredpost.id}
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #show view" do
      get :show, {id: my_sponsoredpost.id}
      expect(response).to render_template :show
    end
    
    it "assigns my_sponsoredpost to @sponsoredpost" do
      get :show, {id: my_sponsoredpost.id}
      expect(assigns(:sponsoredpost)).to eq(my_sponsoredpost)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end
    
    it "instantiates @sponsoredpost" do
      get :new
      expect(assigns(:sponsoredpost)).not_to be_nil
    end
  end
  
  describe "SPONSORED_POST create" do
    it "increases the number of Sponsored Posts by 1" do
      expect{sponsoredpost :create, topic_id: my_topic.id, sponsoredpost: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 99}}.to change(SponsoredPost,:count).by(1)
    end
 
    it "assigns the new sponsored post to @sponsoredpost" do
      sponsoredpost :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 99}
      expect(assigns(:sponsoredpost)).to eq SponsoredPost.last
    end
 
    it "redirects to the new sponsored post" do
      sponsoredpost :create, topic_id: my_topic.id, sponsoredpost: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 99}
      expect(response).to redirect_to [my_topic, SponsoredPost.last]
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, {id: my_sponsoredpost.id}
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #edit view" do
       get :edit, {id: my_sponsoredpost.id}
       expect(response).to render_template :edit
    end
     
    it "assigns sponsoredpost to be updated to @sponsoredpost" do
       get :edit, {id: my_sponsoredpost.id}
 
       sponsoredpost_instance = assigns(:sponsoredpost)
 
       expect(sponsoredpost_instance.id).to eq my_sponsoredpost.id
       expect(sponsoredpost_instance.title).to eq my_sponsoredpost.title
       expect(sponsoredpost_instance.body).to eq my_sponsoredpost.body
    end 
  end
  
  describe "PUT update" do
    it "updates sponsored post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
       
      put :update, topic_id: my_topic.id, id: my_sponsoredpost.id, sponsoredpost: {title: new_title, body: new_body, price: 99}
       
      updated_sponsoredpost = assigns(:sponsoredpost)
      expect(updated_sponsoredpost.id).to eq my_sponsoredpost.id
      expect(updated_sponsoredpost.title).to eq new_title
      expect(updated_sponsoredpost.body).to eq new_body
      expect(updated_sponsoredpost.price).to eq (99)
    end
 
    it "redirects to the updated sponsored post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
       
      put :update, topic_id: my_topic.id, id: my_sponsoredpost.id, sponsoredpost: {title: new_title, body: new_body, price: 99}
      expect(response).to redirect_to [my_topic, my_sponsoredpost]
    end
  end
   
  describe "DELETE destroy" do
    it "deletes the sponsored post" do
      delete :destroy, topic_id: my_topic.id, id: my_sponsoredpost.id
      count = SponsoredPost.where({id: my_sponsoredpost.id}).size
      expect(count).to eq 0
    end
 
    it "redirects to topic show" do
      delete :destroy, topic_id: my_topic.id, id: my_sponsoredpost.id
      expect(response).to redirect_to my_topic
    end
  end
end
