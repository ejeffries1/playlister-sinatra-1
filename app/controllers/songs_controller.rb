require 'rack-flash'

class SongsController < ApplicationController
    enable :sessions
    use Rack::Flash

    get '/songs' do
        @songs = Song.all
        erb :'/song/index'
    end

    get '/songs/new' do
        #@songs = Song.all
        #@genres = Genre.all
        erb :'/song/new'
    end

    get '/songs/:slug' do
        @song = Song.find{|song| song.slug == params[:slug]}
        erb :'/song/show'
    end

    post '/songs' do
        @song = Song.create(:name => params["song"]["name"])
        @song.artist = Artist.find_or_create_by(name: params["artist"]["name"])
        @song.genre_ids = params[:genres]
        @song.save
        
        flash[:message] = "Successfully created song."
        redirect to ("/songs/#{@song.slug}")
    end

    get '/songs/:slug/edit' do
        @song = Song.find{|song| song.slug == params[:slug]}
        erb :'/song/edit'
    end

    post '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])#{|song| song.slug == params[:slug]}
        @song.update(params[:song])
        @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
        @song.genres_ids = params[:genres]
        @song.save

        flash[:message] = "Successfully updated song."
        redirect("/songs/#{@song.slug}")
    end
end