class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.string :name
      t.string :mp3_url
      t.integer :play_count
      t.belongs_to :artist
      t.belongs_to :album

      t.timestamps
    end
  end

  def self.down
    drop_table :tracks
  end
end
