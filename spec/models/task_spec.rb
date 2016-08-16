require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:task)).to be_valid
  end

  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:name) }
end
