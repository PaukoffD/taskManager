require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it 'should return email when to_s' do
    user = FactoryGirl.create(:user)
    expect(user.to_s).to eq(user.email)
  end
end
