class PagesController < ApplicationController
  layout "application", :except => [:next_track]
  def index
    @track = Track.find(:first)
  end

  def prev_track
    @track =  Track.find params[:id]  
  end

  def next_track
    @track = Track.random()
    @track.play_count = @track.play_count+1
    @track.save
  end

  def about
  end

end