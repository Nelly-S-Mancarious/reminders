class Reminder < ApplicationRecord
  belongs_to :user
  after_save :schedule

  def schedule
    #this method handles the case that reminder should be sent this month
    #i.e that it is created prior its firing time this month_day
    #for the rest of months it is handled by the task: lib/run_monthly_schedule
    date = get_date(Date.today)
    schedule_with_date(date)
  end

  def schedule_with_date(date)
    #this method handles the case that reminder should be sent this month
    #i.e that it is created prior its firing time this month_day
    #for the rest of months it is handled by the task: lib/run_monthly_schedule
    date = get_date(Date.today)
    ScheduleRemindersJob.set(wait_until: date).perform_later(self.id) if (DateTime.now < date)
  end

  private

  def get_date(date)
    date = Date.today if date.nil?
    DateTime.new(date.year, date.month, month_day, day_time.hour, day_time.min, day_time.sec)
  end
end
