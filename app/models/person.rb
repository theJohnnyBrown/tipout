class Person < ActiveRecord::Base
  has_many :shifts 
  has_many :days, :through => :shifts
  BARTENDER = 1
  BARBACK = 2
  
  def tips(day)
    myTips = 0
    if (self.role == 1)
      if (!day.shift(self).second_floor)
        myTips = (((day.bartender_hourly)*hours(day))*((100-day.tipout_pct)/100.0))
      else
        myTips = day.second_floor
      end
    end
    if (self.role == 2)
      myTips = ((day.barback_hourly)*hours(day))
      if (day.shift(self).closing_barback)
        myTips += (day.net_tips*(day.tipout_pct/100.0))/day.number_closing_barbacks
      end
    end
    myTips
  end
  
  def hours(day)
    if (day.class == Day)
      shift = shifts.find(:first, :conditions => {:day_id => day.id})
      ret = (shift.time_out - shift.time_in)/(60*60)
    end
    if (day.class == Date)
      shift = shifts.find(:first, :joins=>[:day], :conditions=>{:days => {:when => day}})
      ret = (shift.time_out - shift.time_in)/(60*60)
    end
    ret
  end
end
#aShift = me.shifts.find(:first, :joins=>[:day], :conditions=>{:days => {:when => Date.today}})
