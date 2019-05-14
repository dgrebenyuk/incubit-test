# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validations' do
    it { should validate_presence_of(:email) }
    it { should validate_confirmation_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }
    it { should validate_length_of(:username).is_at_least(5).on(:update) }
  end

  describe '#set_username' do
    it 'should set username from email' do
      user = User.create email: 'testuser@mail.com',
                         password: 'pass1234',
                         password_confirmation: 'pass1234'
      expect(user.username).to eq('testuser')
    end
  end
end
