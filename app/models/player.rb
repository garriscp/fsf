class Player < ActiveRecord::Base
  belongs_to :team
  attr_accessible :fname, :lname, :position, :team
end
