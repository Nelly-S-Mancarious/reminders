class ScheduleRemindersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    #send mail
  end

end
