class Task < ActiveRecord::Base
  include AASM

  aasm :column => 'state' do
    state :new, initial: true
    state :started, :finished
  end

  belongs_to :user

  default_scope { order(created_at: :asc) }

  validates :user, :name, presence: true
end
