FactoryGirl.define do
  factory :user do
    provider 'omniauth provider'
    uid 'user uid'
    name 'user name'
    oauth_token 'auth token'
    oauth_expires_at '2016-10-30 16:40:19'
    image 'user image url'
  end
end
