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
end
