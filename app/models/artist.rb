class Artist < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :albums
  has_many :tracks, :through => :albums
end
