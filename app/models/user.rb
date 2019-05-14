# frozen_string_literal: true

class User < ApplicationRecord
  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  has_secure_password

  validates :email, presence: true, uniqueness: true,
                    format: { with: EMAIL_FORMAT }
  validates :password, confirmation: true, length: { minimum: 8 },
                       if: :will_save_change_to_password_digest?
  validates :username, length: { minimum: 5 },
                       on: :update, if: :will_save_change_to_username?

  before_create :set_username

  def generate_password_token!
    update(reset_password_token: generate_token,
           reset_password_sent_at: Time.now.utc)
    UserMailer.with(user: self).reset_password.deliver_now
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end

  def set_username
    self.username = email.split('@').first
  end
end
