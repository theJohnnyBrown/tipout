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
  validates_presence_of :total_tips
  validates_size_of :shifts, :minimum=>2
  validate :has_barback 
  
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
    if self.has_second_floor?
      total_tips*0.75
    else
      total_tips*0.85
    end
  end
  
  
  
  def second_floor
    if self.has_second_floor?
      total_tips*0.1
    else
      0
    end
  end
  
  def has_second_floor?
    result = false
    self.shifts.each do |s|
      result = result || s.second_floor?
    end
    result
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


  def has_barback
    result = false
    shifts.each do |shift|
      result = (result or shift.closing_barback)
    end
    if(!result) then errors.add_to_base('A day must have at least one barback') end
    return result   
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
