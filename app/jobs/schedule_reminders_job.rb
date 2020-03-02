class ScheduleRemindersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    #send mail
    reminder = Reminder.find_by_id(args[0])
    unless reminder.nil?
      ReminderMailer.with(reminder: reminder).reminder_email.deliver_now
    end
  end

end
