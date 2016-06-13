require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do
  let (:sponsoredpost) { SponsoredPost.create!}
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:topic) { Topic.create!(name: name, description: description) }
  
  it { is_expected.to belong_to(:topic) }
  
  describe "attributes" do
    it "should respond to title" do
      expect(sponsoredpost).to respond_to(:title)
    end
      
    it "should respond to body" do
      expect(sponsoredpost).to respond_to(:body)
    end
      
    it "should respond to price" do
      expect(sponsoredpost).to respond_to(:price)
    end
  end
end
