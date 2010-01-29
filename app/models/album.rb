class Album < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :artist_id
  validates_uniqueness_of :name
  has_one :artist
  has_many :tracks
end