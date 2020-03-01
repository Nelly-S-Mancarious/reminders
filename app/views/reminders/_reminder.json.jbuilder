json.extract! reminder, :id, :title, :description, :month_day, :day_time, :user_id, :created_at, :updated_at
json.url reminder_url(reminder, format: :json)
