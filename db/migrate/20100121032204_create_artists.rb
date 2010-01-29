class CreateArtists < ActiveRecord::Migration
  def self.up
    create_table :artists do |t|
      t.string :name
      t.string :url_name
      t.boolean :is_enabled
      t.has_many :albums
      t.has_many :tracks, :through => :albums
      t.timestamps
    end
  end

  def self.down
    drop_table :artists
  end
end
