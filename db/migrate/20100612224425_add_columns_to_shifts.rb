class AddColumnsToShifts < ActiveRecord::Migration
  def self.up
    add_column :shifts, :closing_barback, :boolean
    add_column :shifts, :second_floor, :boolean
    add_column :days, :closer_id, :integer
    remove_column :days, :person_id
  end

  def self.down
    remove_column :shifts, :second_floor
    remove_column :shifts, :closing_barback
  end
end
