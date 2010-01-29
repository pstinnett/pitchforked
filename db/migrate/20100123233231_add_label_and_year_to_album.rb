class AddLabelAndYearToAlbum < ActiveRecord::Migration
  def self.up
    add_column :albums, :record_label, :string
    add_column :albums, :year, :integer
  end

  def self.down
    remove_column :albums, :year
    remove_column :albums, :record_label
  end
end
