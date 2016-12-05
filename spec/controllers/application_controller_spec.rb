require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      flash[:success] = 'success message'
      flash[:error] = 'error message'
      flash[:notice] = 'notice message'
      flash[:alert] = 'alert message'
      render json: {}
    end

    def create
      flash[:alert] = 'my alert'
    end
  end

  describe '#flash_to_headers' do
    context 'when request is xhr' do
      it 'sets all flashes to response header' do
        post :index, xhr: true

        expect(response.headers['X-Message']).
            to eq 'success:success message,error:error message,alert:alert message,notice:notice message'
      end

      it 'sets only required flashes' do
        post :create, xhr: true

        expect(response.headers['X-Message']).to eq 'alert:my alert'
      end
    end

    context 'when request is not xhr' do
      it 'does not set flash to response header' do
        post :index

        expect(response.headers['X-Message']).to be_nil
      end
    end
  end
end