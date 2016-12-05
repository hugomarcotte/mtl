require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #create" do
    let(:user) { instance_double(User, id: 123) }

    it "returns http success" do
      allow(User).to receive(:from_omniauth).and_return(user)

      get :create

      expect(response).to have_http_status(302)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy

      expect(response).to have_http_status(302)
    end
  end
end
