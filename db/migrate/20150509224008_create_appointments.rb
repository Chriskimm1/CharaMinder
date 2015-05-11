class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
    	t.string :name
    	t.string :phone_number
    	t.text   :tell_yoda
    	t.datetime :time

    	t.timestamps
    end
  end
end

