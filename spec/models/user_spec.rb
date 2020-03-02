require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validaton tests' do
    it 'ensures that the email is mandatry' do
      user = User.new(password: "password")
      u = user.save
      expect(u).to eq(false)
    end

    it 'ensures that the password is mandatry' do
      user = User.new(email: "test@test.com")
      u = user.save
      expect(u).to eq(false)
    end

    it 'can be saved' do
      user = User.new(email: "test@test.com", password: "password")
      u = user.save
      expect(u).to eq(true)
    end
  end
end
