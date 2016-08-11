require 'rails_helper'

RSpec.describe TasksController, type: :controller do

  describe 'GET index' do
    let(:task) { FactoryGirl.create(:task) }

    it 'assigns @tasks' do
      get :index
      expect(assigns(:tasks)).to eq([task])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

end
