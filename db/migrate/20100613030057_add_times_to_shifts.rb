class AddTimesToShifts < ActiveRecord::Migration
  def self.up
    remove_column :shifts, :time_out
    remove_column :shifts, :time_in
    add_column :shifts, :time_in, :datetime
    add_column :shifts, :time_out, :datetime
  end

  def self.down
    remove_column :shifts, :time_out
    remove_column :shifts, :time_in
    add_column :shifts, :time_in, :time
    add_column :shifts, :time_out, :time
  end
end
