class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :session_token, presence: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  has_many :sent_payments, class_name: :Transaction, foreign_key: "sender_id"
  has_many :received_payments, class_name: :Transaction, foreign_key: "receiver_id"

  after_initialize :ensure_session_token

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end



  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def reset_session_token!
    self.session_token ||= SecureRandom::urlsafe_base64
    self.save
    self.session_token
  end


  private

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end
end
