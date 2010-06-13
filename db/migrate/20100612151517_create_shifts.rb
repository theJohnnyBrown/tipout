class CreateShifts < ActiveRecord::Migration
  def self.up
    create_table :shifts do |t|
      t.integer :day_id
      t.integer :person_id
      t.time :time_in
      t.time :time_out
      t.timestamps
    end
    drop_table :days_people
    remove_column :people, :timeOut
    remove_column :people, :timeIn
  end

  def self.down
    drop_table :shifts
  end
end
