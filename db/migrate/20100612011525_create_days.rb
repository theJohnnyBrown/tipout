class CreateDays < ActiveRecord::Migration
  def self.up
    create_table :days do |t|
      t.date :when
      t.integer :total_tips
      t.integer :person_id

      t.timestamps
    end
  end

  def self.down
    drop_table :days
  end
end
