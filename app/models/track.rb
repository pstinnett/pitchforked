class Track < ActiveRecord::Base
  validates_presence_of :artist_id, :album_id
  validates_uniqueness_of :mp3_url
  belongs_to :artist
  belongs_to :album
  
  def self.random
    ids = connection.select_all("SELECT id FROM tracks")
    find(ids[rand(ids.length)]["id"].to_i) unless ids.blank?
  end
end
