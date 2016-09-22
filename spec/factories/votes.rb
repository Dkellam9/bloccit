FactoryGirl.define do
  factory :vote do
    post_id
    user_id
    value :value
  end
end