class Shift < ActiveRecord::Base
  belongs_to :person
  belongs_to :day
  before_save :adjust_times

#  def initialize(attributes={})
#    attr_with_defaults = {:time_in => "7:00 pm", :time_out => "3:00 am"}.merge(attributes)
#    super(attr_with_defaults)
#    adjust_times
#  end
  
  def adjust_times
    unless (time_in.nil? || time_out.nil?)
      if self.time_in > self.time_out then self.time_out += 24*60*60 end
    end
  end
  
end
