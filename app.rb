# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'

require_relative './lib/bookmark'
require_relative './lib/comment'
require_relative './lib/tag'
require_relative './lib/user'
require_relative './database_setup'
require_relative './lib/database_connection'
require 'uri'


class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  set :session_secret, 'super secret'
  register Sinatra::Flash

  get '/' do
    erb :index
  end

  post '/login' do
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:username] = params[:username]
      redirect '/bookmarks'
    else
      flash[:notice] = "Invalid username or password"
      redirect '/'
    end
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    user = User.create(params[:username], params[:password])
    flash[:notice] = "Sign up complete. Please log in."
    redirect '/'
  end

  get '/bookmarks' do
    @user = User.find(session[:username])
    @bookmarks = Bookmark.all
    @tags = Tag.all
    erb :bookmarks, :layout => :layout
  end

  get '/bookmarks/new' do
    erb :new 
  end

  post '/bookmarks' do
    flash[:notice] = "Invalid URL" unless Bookmark.add(title: params[:title], url: params[:url])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])      
    erb :edit, :layout => :layout
  end

  patch '/bookmarks/:id' do
    flash[:notice] = "Invalid URL" unless Bookmark.add(title: params[:title], url: params[:url])
    redirect '/bookmarks'
  end

  post '/bookmarks/:id/comment' do
    Bookmark.add_comment(comments: params[:comments], bookmark_id: params[:id])
    redirect '/'
  end

  get '/tag' do
    erb :tag
  end

  post '/tag' do
    Tag.add(params[:content])
    redirect '/bookmarks'
  end

  post '/bookmarks/:id/tag' do
    Bookmark.add_tag(bookmark_id: params[:id], tag_id: params[:tags])
    redirect '/bookmarks'
  end

  get '/tag/:id' do
    @bookmarks = Bookmark.sort_by_tag(tag_id: params[:id])
    erb :bookmarks_tag
  end

 post '/logout' do
    session.clear
    redirect '/'
  end

  run! if app_file == $PROGRAM_NAME
end
