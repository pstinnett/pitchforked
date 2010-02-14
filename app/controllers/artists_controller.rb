class ArtistsController < ApplicationController
  before_filter :login_required 
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
    @new_album = Album.new
       @new_album.id = 0
       @new_album.artist_id = 0
       @new_album.name = "No Album Found"
       @new_album.is_enabled = true
       @new_album.pf_score = 0
       @new_album.pf_url = "http://www.pitchfork.com"
       @new_album.pf_date = "hello"
       @new_album.artwork_url = "/images/no-artwork.jpg"
       @new_album.record_label = "No Label Found"
       @new_album.year = 2010
    @new_album.save    
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
              review_page = Hpricot(open('http://www.pitchfork.com' + review_url.to_s))
              credits = review_page.search("p[@class='credits']").inner_html.to_s
              regexp = /(?=(January|February|March|April|May|June|July|August|September|October|November|December)).*/
            @new_album.pf_date = credits.match(regexp).to_s
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
    require 'rubygems'
    require 'hpricot'
    require 'open-uri'
      review_page = Hpricot(open('http://pitchfork.com/reviews/albums/13872-teen-dream/'))
      credits = review_page.search("p[@class='credits']").inner_html.to_s
      regexp = /(?=(January|February|March|April|May|June|July|August|September|October|November|December)).*/
      @success = credits.match(regexp)
  end

end