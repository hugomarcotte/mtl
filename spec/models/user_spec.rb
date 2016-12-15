require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:uid) }
  it { should validate_uniqueness_of(:uid) }
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:oauth_token) }
  it { should validate_presence_of(:oauth_expires_at) }

  describe '#from_omniauth' do
    let(:auth) do
      info = OpenStruct.new(name: 'user.name', image: 'user.image')
      credentials = OpenStruct.new(token: 'user.oauth_token', expires_at: Time.now)
      OpenStruct.new(provider: 'user.provider', uid: 'user.uid', info: info, credentials: credentials)
    end

    context 'when user doesnt exists' do
      it 'creates a new user' do
        expect{ described_class.from_omniauth(auth) }.to change{ User.count }.by 1
      end

      it 'new user is updated with auth values' do
        new_user = described_class.from_omniauth(auth)

        expect(new_user.provider).to eq auth.provider
        expect(new_user.uid).to eq auth.uid
        expect(new_user.name).to eq auth.info.name
        expect(new_user.oauth_token).to eq auth.credentials.token
        expect(new_user.oauth_expires_at).to eq Time.at(auth.credentials.expires_at)
        expect(new_user.image).to eq auth.info.image
      end
    end

    context 'when user exists' do
      let(:user) { create(:user) }

      it 'returns user' do
        auth.uid = user.uid
        auth.provider = user.provider

        expect(described_class.from_omniauth(auth).id).to eq user.id
      end

      it 'existing user is updated with auth values' do
        returned_user = described_class.from_omniauth(auth)

        expect(returned_user.provider).to eq auth.provider
        expect(returned_user.uid).to eq auth.uid
        expect(returned_user.name).to eq auth.info.name
        expect(returned_user.oauth_token).to eq auth.credentials.token
        expect(returned_user.oauth_expires_at).to eq Time.at(auth.credentials.expires_at)
        expect(returned_user.image).to eq auth.info.image
      end
    end
  end
end