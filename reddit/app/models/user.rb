class User < ApplicationRecord
  validates :username, :password_digest, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  has_many(:posts,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'Post'
  )

  has_many(:moderator_memberships,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'Moderator'
  )

  has_many(:modded_subs,
    through: :moderator_memberships,
    source: :sub
  )

  after_initialize :ensure_session_token

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil if user.nil?
    if BCrypt::Password.new(user.password_digest).is_password?(password)
      user
    else
      nil
    end
  end




end
