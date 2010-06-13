class Shift < ActiveRecord::Base
  belongs_to :person
  belongs_to :day
  before_save :adjust_times

  
  def adjust_times
    unless (time_in.nil? || time_out.nil?)
      if self.time_in > self.time_out then self.time_out += 24*60*60 end
    end
  end
  
end
