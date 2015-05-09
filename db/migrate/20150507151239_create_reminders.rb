class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
    	t.string :name
    	t.string :phone_number
    	t.string :time
    	t.text   :reminder

    	t.timestamps
    end
  end
end
