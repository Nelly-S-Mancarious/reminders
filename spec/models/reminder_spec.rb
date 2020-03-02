require 'rails_helper'

RSpec.describe Reminder, type: :model do
  context 'validaton tests' do
    before(:each) do
      @user = FactoryBot.create(:user, email: "test@test.com")
    end

    it 'ensures that the title is mandatry' do
      reminder = Reminder.new(month_day: 2, day_time: "06:40:00", user_id: @user.id)
      r = reminder.save
      expect(r).to eq(false)
    end

    it 'ensures that the Month day is mandatry' do
      reminder = Reminder.new(title: "test", day_time: "06:40:00", user_id: @user.id)
      r = reminder.save
      expect(r).to eq(false)
    end

    it 'ensures that the day_time  is mandatry' do
      reminder = Reminder.new(title: "test", month_day: 2, user_id: @user.id)
      r = reminder.save
      expect(r).to eq(false)
    end

    it 'ensures that the Month day is within -31 and 31' do
      reminder = Reminder.new(title: "test",  day_time: "06:40:00", month_day: 33, user_id: @user.id)
      r = reminder.save
      expect(r).to eq(false)
    end

    it 'can be saved' do
      reminder = Reminder.new(title:"test", month_day: 2, day_time: "06:40:00", user_id: @user.id)
      r = reminder.save
      expect(r).to eq(true)
    end
  end
end
