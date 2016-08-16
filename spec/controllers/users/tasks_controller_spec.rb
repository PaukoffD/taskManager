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

        get :index, {user_id: user.id}

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
        get :index, {user_id: user.id}
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'return only user tasks' do
        user2 = FactoryGirl.create(:user)
        FactoryGirl.create(:task, user: user)
        FactoryGirl.create(:task, user: user2)

        get :index, {user_id: user.id}

        assigns(:tasks).each do |task|
          expect(task.user).to eq user
        end

      end
    end
  end

  describe '#state' do
    let(:user) { FactoryGirl.create(:user) }
    let(:task) { FactoryGirl.create(:task, user: user, state: 'new') }

    it 'assign task' do
      post :state, {user_id: user.id, id: task.id}
      expect(assigns(:task)).to eq task
    end

    it 'change state' do
      post :state, {user_id: user.id, id: task.id, state: 'started'}
      expect(assigns(:task).state).to eq 'started'
    end
  end

  describe '#new' do
    let(:user) { FactoryGirl.create(:user) }

    it 'assign new task' do
      get :new, {user_id: user.id}
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe '#create' do
    let(:user) { FactoryGirl.create(:user) }

    context 'with valid params' do
      it 'add new task' do
        expect {
          post :create, {task: attributes_for(:task).merge(user_id: user.id), user_id: user.id}
        }.to change(Task, :count).by(1)
      end

    end

    context 'with invalid params' do
      it 'does not save the new contact in the database' do
        expect {
          post :create, {task: attributes_for(:task).merge(user_id: nil), user_id: user.id}
        }.to_not change(Task, :count)
      end


    end
  end

  describe '#update' do
    let(:user) { create(:user) }
    let(:task) { create(:task, user: user, name: 'Задача', description: 'Описание') }

    context 'valid attributes' do
      before :each do
        session[:user_id] = user.id
      end

      it 'find task' do
        patch :update, {user_id: user.id, id: task.id, task: attributes_for(:task)}
        expect(assigns(:task)).to eq(task)
      end
      it 'change task attrs' do
        patch :update, {user_id: user.id, id: task.id, task: attributes_for(:task,
                                                                            name: 'Задача2', description: 'Описание2').merge(user_id: user.id)}
        task.reload
        expect(task.name).to eq('Задача2')
        expect(task.description).to eq('Описание2')

      end
    end

    context 'with invalid attributes' do
      before :each do
        session[:user_id] = user.id
      end

      it 'render edit' do
        patch :update, {user_id: user.id, id: task.id, task: attributes_for(:task,
                                                                            name: nil, description: 'Описание2').merge(user_id: user.id)}
        expect(response).to render_template :edit
      end
    end
  end

  describe '#destroy' do
    let(:user) { create(:user) }

    before :each do
      session[:user_id] = user.id
    end

    it 'delete a task' do
      task = create(:task, user: user)
      expect {delete :destroy, {id: task.id, user_id: user.id}}.to change(Task,:count).by(-1)
    end

    it 'redirect to users task' do
      task = create(:task, user: user)
      delete :destroy, {id: task.id, user_id: user.id}
      expect(response).to redirect_to user_tasks_path(user)
    end
  end
end
