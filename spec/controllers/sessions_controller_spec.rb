require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe '#create' do
    let(:user_params) do
      {email: Faker::Internet.email, password: 'password'}
    end

    let(:user) { FactoryGirl.create(:user, user_params) }

    context 'with valid params' do

      before :each do
        post :create, sessions: {email: user.email, password: user.password}
      end

      it 'should redirect to user tasks' do
        expect(response).to redirect_to(user_tasks_path(user))
      end

      it 'flash message should be good' do
        expect(flash[:notice]).to eq 'Вы вошли в систему.'
      end

      it 'should authenticate user' do
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context 'with invalid params' do
      before :each do
        post :create, sessions: {user_params: {password: 'wrongpass'}}
      end

      it 'should render new template' do
        expect(response).to render_template(:new)
      end
      it 'flash message should be bad' do
        expect(flash[:alert]).to eq 'Неверные почта или пароль'
      end
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe '#destroy' do

    let(:user) { FactoryGirl.create(:user) }

    it 'user should be logged in' do
      post :create, sessions: {email: user.email, password: user.password}
      expect(session[:user_id]).to eq(user.id)
    end

    context 'when user is login'
      subject { delete :destroy, id: user.id }

      it 'destroys user session' do
        expect(session[:user_id]).to be_nil
      end

      it 'redirect to root after destroy' do
        expect(subject).to redirect_to(root_path)
      end
  end

end
