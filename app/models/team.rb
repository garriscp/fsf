class Team < ActiveRecord::Base
  belongs_to :user
  has_many :passignments, :dependent => :destroy
  has_many :players, :through => :passignments
  attr_accessible :name
  accepts_nested_attributes_for :players
end
