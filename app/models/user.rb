class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token

  has_many :subs,
    foreign_key: :moderator_id

  has_many :comments,
    foreign_key: :author_id

  has_many :posts,
    foreign_key: :author_id

  attr_reader :password

  def self.find_by_credentials(username, pw)
    user = User.find_by(username: username)
    return nil if user.nil?
    user.is_password?(pw) ? user : nil
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    pwdigest = BCrypt::Password.new(self.password_digest)
    pwdigest.is_password?(pw)
  end

  def generate_session_token
    SecureRandom.urlsafe_base64(32)
  end

  def ensure_session_token
    self.session_token ||= self.generate_session_token
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save
  end
end
