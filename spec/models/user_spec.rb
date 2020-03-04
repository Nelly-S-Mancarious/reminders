require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validaton tests' do
    it 'ensures that the email is mandatry' do
      expect { FactoryBot.create(:user, password: "password") }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'ensures that the password is mandatry' do
      expect { FactoryBot.create(:user, email: "test@test.com") }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'can be saved' do
      FactoryBot.create(:user, email: "test@test.com", password: "password")
      expect(User.all.count ).to eq(1)
    end

    it 'makes the email unique' do
      FactoryBot.create(:user, email: "test@test.com", password: "password")
      expect { FactoryBot.create(:user, email: "test@test.com", password: "password") }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
