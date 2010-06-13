class Shift < ActiveRecord::Base
  belongs_to :person
  belongs_to :day
end
