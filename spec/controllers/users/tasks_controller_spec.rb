require 'rails_helper'

RSpec.describe Users::TasksController, type: :controller do

  describe '#index' do

    context 'user is admin' do
      let(:user) { FactoryGirl.create(:user, :admin) }

      before :each do
        session[:user_id] = user.id
      end

      it 'return tasks of all users' do
        user2 = FactoryGirl.create(:user)
        FactoryGirl.create(:task, user: user)
        FactoryGirl.create(:task, user: user2)

        get :index, { user_id: user.id }

        assigns(:tasks).each do |task|
          expect(task.user.id).to eq(user.id).or(eq(user2.id))
        end
      end
    end

    context 'any user' do
      let(:user) { FactoryGirl.create(:user) }

      before :each do
        session[:user_id] = user.id
      end

      it 'responds successfully with an HTTP 200 status code' do
        get :index, { user_id: user.id }
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'return only user tasks' do
        user2 = FactoryGirl.create(:user)
        FactoryGirl.create(:task, user: user)
        FactoryGirl.create(:task, user: user2)

        get :index, { user_id: user.id }

        assigns(:tasks).each do |task|
          expect(task.user).to eq user
        end

      end
    end
  end

end
