class GenresController < ApplicationController

    get '/genres' do
        @genres = Genre.all
        erb :'/genre/index'
    end
    
    get '/genres/:slug' do
        @genre = Genre.find{|genre| genre.slug == params[:slug]}
        erb :'/genre/show'
    end

end