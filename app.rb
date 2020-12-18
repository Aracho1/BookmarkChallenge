# frozen_string_literal: true

require 'sinatra/base'
require_relative './lib/bookmark.rb'
require_relative './database_setup.rb'
require_relative './lib/database_connection.rb'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override

  get '/' do
    'Hello World'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb(:bookmarks)
  end

  get '/bookmarks/new' do
    erb :new
  end

  post '/bookmarks' do
    Bookmark.add(title: params[:title], url: params[:url])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  # put '/bookmarks/:id' do
  #   erb :edit
  #   # @bookmark.edit(params[:url], params[:title])
  #   # redirect "bookmarks/#{params[:id]}"
  # end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])
    erb :edit
  end

  patch '/bookmarks/:id' do
    Bookmark.edit(id: params[:id], title: params[:title], url: params[:url])
    redirect '/bookmarks'
  end

  run! if app_file == $PROGRAM_NAME
end
