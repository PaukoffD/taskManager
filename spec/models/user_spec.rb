require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it 'should return email when to_s' do
    user = FactoryGirl.create(:user)
    expect(user.to_s).to eq(user.email)
  end

  it { is_expected.to have_many(:tasks) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(4) }
  it { is_expected.to validate_length_of(:email).is_at_most(254) }

  it { is_expected.to have_secure_password }
end
