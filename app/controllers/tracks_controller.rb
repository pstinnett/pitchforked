class TracksController < ApplicationController
  def new
  end
  
  def import
    require 'base64'
    require 'rest_client'
    require 'json'
    @success = []
    creds = 'niwCFilfWCZqF' + ':' + '0c8e7f31519d0b9d576405e0cb4f0b037fcfa4ec'
    url = 'http://' + creds + '@api.8tracks.com/'
    playtoken_r = RestClient.get url + '/sets/new.json', 
      :headers => { 
        :content_type => 'text/xml', 
      }
    j = JSON.parse(playtoken_r)
    playtoken = j['play_token']
    @playtoken = playtoken
    if params[:id] != nil     #This imports tracks based on an artist ID
      id = params[:id].to_i
      conditions = 'id = ' + id.to_s
      artist = Artist.find(:first, :conditions => conditions)

      mix_r = RestClient.get url + 'mixes.json?per_page=50&q=' + artist.url_name + '&sort=recent'
      mixes_arr = JSON.parse(mix_r)

      mixes_arr['mixes'].each do |mix|
        track_r = RestClient.get url + '/sets/' + playtoken + '/play.json?mix_id=' + mix['id'].to_s
        tracks_arr = JSON.parse(track_r)
        tracks_arr['track'].each do |track|
          if tracks_arr['track']['contributor'] == artist.name
            @new_track = Track.new
              @new_track.name = tracks_arr['track']['title']
              @new_track.mp3_url = tracks_arr['track']['item']
              @new_track.play_count = 0
              @new_track.artist_id = id #album.artist_id
              conditions = 'name = "' + tracks_arr['track']['album'] + '"'
              album = Album.find(:first, :conditions=> conditions)
              if album != nil
                @new_track.album_id = album.id
              else
                @new_track.album_id = 0
              end
              @new_track.save
              @success << mixes_arr
          end
        end     
      end
    else      #This loops through all artist tracks and imports for each
      conditions = 'is_enabled = true'
      artists = Artist.find(:all, conditions)
      artists.each do |artist|
        mix_r = RestClient.get url + 'mixes.json?per_page=10&q=' + artist.url_name + '&sort=recent'
        mixes_arr = JSON.parse(mix_r)

        mixes_arr['mixes'].each do |mix|
          track_r = RestClient.get url + '/sets/' + playtoken + '/play.json?mix_id=' + mix['id'].to_s
          tracks_arr = JSON.parse(track_r)
          tracks_arr['track'].each do |track|
            if tracks_arr['track']['contributor'] == artist.name
              @new_track = Track.new
                @new_track.name = tracks_arr['track']['title']
                @new_track.mp3_url = tracks_arr['track']['item']
                @new_track.play_count = 0
                @new_track.artist_id = id #album.artist_id
                conditions = 'name = "' + tracks_arr['track']['album'] + '"'
                album = Album.find(:first, :conditions=> conditions)
                if album != nil
                  @new_track.album_id = album.id
                else
                  @new_track.album_id = 0
                end
              @new_track.save
                @success << tracks_arr
            end
          end     
        end
      end
    end
  end
  
  def more
  end
end
