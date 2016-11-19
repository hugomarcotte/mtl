FactoryGirl.define do
  factory :city, class: 'City' do
    name "MyString"
  end
  factory :user do
    provider "MyString"
    uid "MyString"
    name "MyString"
    oauth_token "MyString"
    oauth_expires_at "2016-10-30 16:40:19"
  end
end
