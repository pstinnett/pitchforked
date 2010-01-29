class ArtistsController < ApplicationController
  def new
    @artist = Artist.new
  end
  
  def show
    @artist = Artist.find params[:id]  
  end
  
  def create
    @artist = Artist.new params[:artist]
    if @artist.save
      flash[:notice] = "#{@artist.name} saved."
      redirect_to @artist
    else
      render :new
    end
  end
  
  def load
    require 'rubygems'
    require 'hpricot'
    require 'open-uri'
    @artists = []
    11.times do |i|
      if i > 0
        page = Hpricot(open('http://pitchfork.com/reviews/best/albums/' + i.to_s))
        items = page.search("//div[@class='panel']//div[@class='panel']").each do |panel|
          pp panel
          #find artist name and save
          artist_name = panel.search("//span[@class='artists']/a/b").inner_html
          album_name = panel.search("//span[@class='albums']/a").inner_html
          review_score = panel.search("//div[@class='large_rating']").inner_html
          review_url = panel.search("//span[@class='albums']/a").first[:href]
          album_art = panel.search("//img[@class='tombstone-cover-image']").first[:src]
          record_label = panel.search("span[@class='labels']/a").inner_html
          year = panel.at("span[@class='labels']").children.select{|e| e.text?}
          @new_artist = Artist.new
            @new_artist.name = artist_name
            @new_artist.url_name = artist_name.to_s.gsub(/[ ]/, "+").downcase
            @new_artist.is_enabled = true
          @new_artist.save
          @new_album = Album.new
            @new_album.artist_id = @new_artist.id
            @new_album.name = album_name
            @new_album.is_enabled = true
            @new_album.pf_score = review_score
            @new_album.pf_url = 'http://www.pitchfork.com' + review_url.to_s
            @new_album.artwork_url = album_art.to_s
            @new_album.record_label = record_label.to_s
            @new_album.year = year.join.to_s.gsub(/[^0-9]/, '').to_i
          @new_album.save
          @artists << artist_name
        end
      end
    end
  end
  
  def more
  end

end