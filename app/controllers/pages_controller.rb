class PagesController < ApplicationController
  before_filter :login_required, :only => [ :manage ]
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
  
  def manage
  end

  def about
  end

end