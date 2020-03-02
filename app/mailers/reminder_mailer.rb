class ReminderMailer < ApplicationMailer
  default to: -> { User.pluck(:email) }

  def reminder_email
    @reminder =  params[:reminder]
    mail(subject: @reminder.title)
  end
end
