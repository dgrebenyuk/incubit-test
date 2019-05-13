class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :password, confirmation: true, length: { minimum: 8 }, if: :will_save_change_to_password_digest?
  validates :username, length: { minimum: 5 }, on: :update

  before_create :set_username

  private

  def set_username
    self.username = self.email.split('@').first
  end
end
