require 'rails_helper'

RSpec.describe Reminder, type: :model do
  context 'validaton tests' do
    before(:each) do
      @user = FactoryBot.create(:user, email: "test@test.com", password: "password")
    end

    it 'ensures that the title is mandatry' do
      expect { FactoryBot.create(:reminder, month_day: 2, day_time: "06:40:00", user_id: @user.id) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'ensures that the Month day is mandatry' do
      expect { FactoryBot.create(:reminder, title: "title", day_time: "06:40:00", user_id: @user.id) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'ensures that the Month day is within -31 and 31' do
      expect { FactoryBot.create(:reminder, title: "title", month_day: 32, day_time: "06:40:00", user_id: @user.id) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'ensures that the day_time  is mandatry' do
      expect { FactoryBot.create(:reminder, title: "title", month_day: 2, user_id: @user.id) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'ensures that the day_time is time' do
      expect { FactoryBot.create(:reminder, title: "title", month_day: 2, day_time: "time", user_id: @user.id) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'ensures that the user is mandatory' do
      expect {FactoryBot.create(:reminder, title: "title", month_day: 2, day_time: "06:40:00") }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'can be saved' do
      FactoryBot.create(:reminder, title: "title", month_day: 2, day_time: "06:40:00", user_id: @user.id)
      expect( Reminder.all.count ).to eq(1)
    end
  end
end
