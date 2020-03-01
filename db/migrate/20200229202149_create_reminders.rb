class CreateReminders < ActiveRecord::Migration[5.2]
  def change
    create_table :reminders do |t|
      t.string :title
      t.text :description
      t.integer :month_day
      t.time :day_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
