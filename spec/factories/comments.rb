include RandomData

FactoryGirl.define do
  factory :comment do
      body RandomData.random_paragraph
      user 
      topic_id
      post_id
  end
end