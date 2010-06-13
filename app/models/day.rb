class Day < ActiveRecord::Base
  BARTENDER = 1
  BARBACK = 2

  has_many :shifts, :dependent => :destroy
  has_many :people, :through => :shifts
  belongs_to :closer, :class_name => "Person"
  accepts_nested_attributes_for :shifts
  
  def self.hour_minute(time)
    "#{time.hour}:#{time.min}"
  end
  
  def second_floor
    total_tips*0.1
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
  
  def bartender_hourly
    net_tips/bartender_hours
  end
  
  def barback_hourly
    barback_total/barback_hours
  end
  
  def barback_hours
    barbackHours = 0
    people.each do |person|
      if (person.role == Person::BARBACK) then barbackHours = barbackHours + person.hours(self) end
    end
    barbackHours
  end
  
  def bartender_hours
    bartenderHours = 0
    people.each do |person|
    if (person.role == Person::BARTENDER) then bartenderHours = bartenderHours + person.hours(self) end
    end
    bartenderHours
  end
end
