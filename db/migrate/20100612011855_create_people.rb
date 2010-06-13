class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.integer :role
      t.time :timeIn
      t.time :timeOut

      t.timestamps
    end
    create_table :days_people, :id => false do |t|
      t.references :day, :person
    end
  end

  def self.down
    drop_table :people
  end
end
