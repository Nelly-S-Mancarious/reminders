namespace :run_monthly_schedule do
  task run: :environment do
    Reminder.all.each do |remind|
      remind.schedule_with_date(Date.today.next_month)
    end
  end
end
