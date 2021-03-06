FactoryGirl.define do
  factory :user do
=begin
    name      "Michael Hartl"
    email     "michael@example.com"
=end
    sequence(:name)   { |n| "Person #{n}" }
    sequence(:email)  { |n| "person_#{n}@example.com" }
    password  "foobar"
    password_confirmation   "foobar"
    
    factory :admin do
      admin true
    end # admin
  end # user
  
  
  factory :micropost do
    content "Lorem ipsum"
    user
  end # micropost
    
end


