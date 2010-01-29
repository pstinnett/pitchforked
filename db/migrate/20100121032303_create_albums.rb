class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string :name
      t.boolean :is_enabled
      t.integer :pf_score
      t.string :pf_url
      t.string :artwork_url
      t.belongs_to :artist
      t.has_many :tracks

      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
