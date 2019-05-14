class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :password, confirmation: true, length: { minimum: 8 }, if: :will_save_change_to_password_digest?
  validates :username, length: { minimum: 5 }, on: :update, if: :will_save_change_to_username?

  before_create :set_username

  def generate_password_token!
    self.update(reset_password_token: generate_token, reset_password_sent_at: Time.now.utc)
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end

  def set_username
    self.username = self.email.split('@').first
  end
end
