#Overview
Sending reminders is handled through:

*run_monthly_schedule* task that is defined in 'lib/tasks/folder'. With the whenever gem, this task runs once every month. To ensure that it runs every month, it is designed to run on the 28th day of every month(to avoid problems that might arise in case of months with 30 days, only in addition to Febraury).It runs at 11PM. This task loops on the reminders in the database and calculates the day at which each reminder shall be sent in the coming month and enqueues this reminder at the specified date and time in a Sidekiq queue. This happens according to the following rules:

1)if the reminder should be sent at day 31 from the start of the month and there is no day 31 in the following month, the reminder in moved to the last day in the coming month. The same logic handles the month of Febraury having 28 or 29 days only.

2)If the reminder is scheduled to run on the day number 31 from the end of the month, and there is no 31 days in the coming month, it is scheduled to run on the first day of month. The same logic handles the month of Febraury having 28 or 29 days only.
The above 2 points in handled in the reminder model in a method called "get_date".

*ScheduleRemindersJob* Job:If a reminder that is scheduled to run on a day that is after its creation date day, it is scheduled to run on that day(of the creation month) using this job. So for example if a reminder is created on the 5th of the month and it is scheduled to run on the 25th of every month. The "ScheduleRemindersJob" schedules it for the first time only to run on its creation month. After this it is handled by the "run_monthly_schedule" and scheduled on a monthly routine with the rest of the reminders.(Point 1 and 2 above also are valid for the ScheduleRemindersJob job)

It is worth noting that the "run_monthly_schedule" task uses the "ScheduleRemindersJob" to schedule individual reminder (this is done through the "schedule_with_date" method in the model)

#Handling reminder deletetion after being scheduled
To avoid any problems that might happen in this case, immediately before sending the mail, the reminder is fetched from the data base and the system sends the email only if the reminder is found in the database (line 7 in ScheduleRemindersJob)

#Database:
The database consists of 2 tables: the users table and the reminders table where there is an has_many association between them. In case the reminder is scheduled relative to the end of month, the "month_day" id stored with a negative sign. (-1 one denotes the end of month and -2 denotes the day before the last month day and so on).

#Authentication
User registration and login is handled through the devise gem

#Tests
tests is handled with the rspec gem where the specs are stored in the spec folder
