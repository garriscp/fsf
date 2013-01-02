class Player < ActiveRecord::Base
  has_many :passignments
  has_many :teams, :through => :passignments
  attr_accessible :fname, :lname, :position, :team
end
