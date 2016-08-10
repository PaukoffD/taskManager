class User < ActiveRecord::Base
  has_secure_password
  include AASM

  aasm :column => 'role' do
    state :user, initial: true
    state :admin
  end

  has_many :tasks

  default_scope { order(email: :asc) }

  validates :email, presence: true,
                    uniqueness: true,
                    length: {:minimum => 4, :maximum => 254},
                    format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  def to_s
    self.email
  end
end
