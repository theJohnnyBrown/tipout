  class Time
    def hm_string
      self.strftime "%I:%M %p"
    end
  end
  
class Date
  def weekday
    weekdays = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday']
    weekdays[self.wday]
  end
end

class Day < ActiveRecord::Base
  BARTENDER = 1
  BARBACK = 2
  


  has_many :shifts,:dependent => :destroy
  accepts_nested_attributes_for :shifts, :reject_if => lambda { |a| a.values.all?(&:blank?) }, :allow_destroy => true 
  has_many :people, :through => :shifts
  belongs_to :closer, :class_name => "Person"
  
  def initialize(attributes={})
    attr_with_defaults = {:when => (Date.today-1), :tipout_pct => 5}.merge(attributes)
    super(attr_with_defaults)
  end
  
  def self.hour_minute(time)
    "#{time.hour}:#{time.min}"
  end
  
  def <=> (second)
    aval = Date.new
    bval = Date.new
    aval = self.when if self.when
    bval = second.when if second.when
    aval <=> bval
  end
    
  def number_closing_barbacks
    num = 0
    people.each do |p|
      if (shift(p).closing_barback)
      num = num + 1
      end
    end
    num
  end
  
  def shift(person)
    self.shifts.find_by_person_id(person.id)
  end
  
  def barback_total
    total_tips*0.15
  end
  
  def net_tips
    total_tips*0.75
  end
  
  
  
  def second_floor
    total_tips*0.1
  end
  
  def bartender_hourly
    (((net_tips/bartender_hours)*100).round)/100.0
  end
  
  def barback_hourly
    (((barback_total/barback_hours)*100).round)/100.0
  end
  
  def barback_hours
    barbackHours = 0
    people.each do |person|
      if (person.role == Person::BARBACK) then barbackHours = barbackHours + person.hours(self) end
    end
    barbackHours
  end
  
  def times
    t = Time.parse "12:00 pm"
    ts = []
    48.times do |x|
      ts << t
      t += 30*60
    end
    ts
  end
  
  def bartender_hours
    bartenderHours = 0
    people.each do |person|
    if (person.role == Person::BARTENDER  && (!shift(person).second_floor)) then bartenderHours = bartenderHours + person.hours(self) end
    end
    bartenderHours
  end
end
