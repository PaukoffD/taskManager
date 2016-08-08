class Task < ActiveRecord::Base
  include AASM

  aasm :column => 'state' do
    state :new, initial: true
    state :started, :finished
  end

  belongs_to :user
end
