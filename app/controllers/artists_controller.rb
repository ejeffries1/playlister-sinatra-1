class ArtistsController < ApplicationController

    get '/artists' do
        @artists = Artist.all
        erb :'/artist/index'
    end

    get '/artists/:slug' do
      @artist = Artist.find{|artist| artist.slug == params[:slug]}
      erb :'/artist/show'
    end
end
