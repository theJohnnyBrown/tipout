class Person < ActiveRecord::Base
  has_many :shifts 
  has_many :days, :through => :shifts
  BARTENDER = 1
  BARBACK = 2
  
  def tips(day) #after barback tipout
    myTips = 0
    if (self.role == BARTENDER)
      if (!day.shift(self).second_floor)
        myTips = (((day.bartender_hourly)*hours(day))*((100-day.tipout_pct)/100.0))
      else
        myTips = day.second_floor
      end
    end
    if (self.role == BARBACK)
      myTips = ((day.barback_hourly)*hours(day))
      if (day.shift(self).closing_barback)
        myTips += (day.net_tips*(day.tipout_pct/100.0))/day.number_closing_barbacks
      end
    end
    myTips
  end
  
  def gross_tips(day)
    netTips = 0 
    if (self.role == BARTENDER)
      if (day.shift(self).second_floor) then netTips = tips(day)
      else netTips = day.bartender_hourly*hours(day) end
    end
    if (self.role == BARBACK) then netTips = ((day.barback_hourly)*hours(day)) end
    netTips
  end
  
  def tipout(day)
    myTipout = 0
    if (self.role == BARTENDER && (!day.shift(self).second_floor)) then myTipout = gross_tips(day)*day.tipout_pct/100.0 end
    if (self.role == BARBACK && (day.shift(self).closing_barback)) then myTipout = (day.net_tips*(day.tipout_pct/100.0))/day.number_closing_barbacks end
    myTipout
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
