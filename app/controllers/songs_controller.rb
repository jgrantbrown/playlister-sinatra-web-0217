require 'rack-flash'

class SongController < ApplicationController
use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :"./songs/index"
  end

  get '/songs/new' do
    erb :"./songs/new"
  end

  get '/songs/:slug' do
      @song = Song.find_by_slug(params[:slug])
      erb :"./songs/show"
  end

  post '/songs' do
      artist = Artist.find_or_create_by(name: params[:artist_name])
      @song = Song.create(name: params[:song_name])
      # Itereate ove genres and add if multiple chosen
      params[:genres].each do |genre_id|
        genre = Genre.find(genre_id)
        @song.genres<<genre
      end

      @song.artist = artist

      @song.save

      flash[:message] = "Successfully created song."
      redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])

    erb :"./songs/edit"
  end



  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])

    @song.name = params[:song_name]

    params[:genres].each do |genre_id|
      genre = Genre.find(genre_id)
      @song.genres<<genre
    end
    @song.artist = Artist.find_or_create_by(name: params[:artist_name])
    @song.save

    flash[:message] = "Successfully updated song."
     redirect to("/songs/#{@song.slug}")
  end



end
