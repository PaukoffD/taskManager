class Task < ActiveRecord::Base
  include AASM

  aasm :column => 'state' do
    state :new, initial: true
    state :started, :finished
  end

  mount_uploader :file, FileUploader

  belongs_to :user

  default_scope { order(created_at: :desc) }

  validates :user, :name, presence: true
end
