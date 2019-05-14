# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET new' do
    context 'already logged in' do
      before do
        login(create(:user))
      end

      it 'should redirect to user profile if user is logged in' do
        get :new
        expect(response).to redirect_to(user_path)
      end
    end
  end

  describe 'POST create' do
    let!(:user) { create(:user, password: 'pass1234') }

    it 'should login with proper credentials' do
      post :create, params: { email: user.email, password: 'pass1234' }
      expect(response).to redirect_to(user_path)
    end

    it 'should not login with bad credentials' do
      post :create, params: { email: user.email, password: '123' }
      expect(response.status).to eq(200)
      expect(request.flash[:alert]).to_not be_nil
    end
  end
end
