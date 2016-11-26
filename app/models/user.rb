class User < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  validates :provider, :name, :oauth_token, :oauth_expires_at, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.image = auth.info.image
      user.save!
    end
  end

  private

  def user_params
    params.permit(:provider, :uid, :name, :oauth_token, :oauth_expires_at)
  end
end
