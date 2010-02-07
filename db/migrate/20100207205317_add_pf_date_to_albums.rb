class AddPfDateToAlbums < ActiveRecord::Migration
  def self.up
    add_column :albums, :pf_date, :string
  end

  def self.down
    remove_column :albums, :pf_date
  end
end
