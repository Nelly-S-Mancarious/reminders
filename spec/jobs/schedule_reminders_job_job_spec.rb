require 'rails_helper'

RSpec.describe ScheduleRemindersJob, type: :job do
  describe "#perform_later" do
    it "schedules an email sending" do
      ActiveJob::Base.queue_adapter = :test
      user = FactoryBot.create(:user, email: "test@test.com")
      reminder = Reminder.create(title:"test", month_day: 2, day_time: "06:40:00", user_id: user.id)

      expect {
        ScheduleRemindersJob.perform_later(reminder.id)
      }.to have_enqueued_job
    end
  end
end
