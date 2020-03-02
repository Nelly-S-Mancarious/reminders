require "rails_helper"

RSpec.describe ReminderMailer, type: :mailer do
  describe "user request update" do
  let(:user) { FactoryBot.create(:user) }


  it "#notify_users should notify both users" do
    reminder = Reminder.create!(title: "title", month_day: 2, day_time: "06:40:00", user_id: user.id)
    ReminderMailer.with(reminder: reminder).reminder_email.deliver_now
    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(ActionMailer::Base.deliveries.last.to).to include(user.email)
  end
end
end
