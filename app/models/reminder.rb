class Reminder < ApplicationRecord
  belongs_to :user
  after_save :schedule

  validates :title,     presence: true
  validates :month_day, presence: true
  validates :day_time,  presence: true
  validates :user_id,   presence: true

  validates :month_day, :inclusion => { :in => -31..31 }  

  def schedule
    #this method handles the case that reminder should be sent this month
    #i.e that it is created prior its firing time this month_day
    #for the rest of months it is handled by the task: lib/run_monthly_schedule
    schedule_with_date(Date.today)
  end

  def schedule_with_date(date)
    #this method handles the case that reminder should be sent this month
    #i.e that it is created prior its firing time this month_day
    #for the rest of months it is handled by the task: lib/run_monthly_schedule
    date = get_date(date)
    ScheduleRemindersJob.set(wait_until: date).perform_later(self.id) if (DateTime.now < date)
  end

  private

  def get_date(date)

    date = Date.today if date.nil?
    begin
      date = day_time.change({ year: date.year, month: date.month, day: month_day })
    rescue
      if month_day > 0
        #case the month_day is positive and there is no such day in this month
        #for example there is no day 30 in February, so the email should be send at the last day of month
        date =  day_time.change({ year: date.year, month: date.month, day: date.end_of_month.day })
      else
        #if the month_day is negative and there is no such day in such a month
        #for example there is no day 31 in month of April
        date = day_time.change({ year: date.year, month: date.month, day: 1 })
      end
    end
    date
  end
end
