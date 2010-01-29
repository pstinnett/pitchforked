class AlbumsController < ApplicationController
  def new
    @album = Album.new
  end
  
  def show  
    @album = Album.find params[:id]  
  end
  
  def create
    @album = Album.new params[:album]
    if @album.save
      flash[:notice] = "#{@album.name} saved."
      redirect_to @album
    else
      render :new
    end
  end
end