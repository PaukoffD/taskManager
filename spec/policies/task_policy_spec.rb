require 'rails_helper'

RSpec.describe TaskPolicy do
  subject { described_class.new(user, task) }

  let(:resolved_scope) do
    described_class::Scope.new(user, Task.all).resolve
  end

  context 'user is admin' do
    let(:user) { create(:user, :admin) }
    let(:task) { create(:task, user: user)}

    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

end
