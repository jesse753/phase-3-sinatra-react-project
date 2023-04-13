require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/contrib'
require 'json'

# Load the models
Dir.glob(File.join(__dir__, 'models', '*.rb')).each { |file| require file }

class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Enable sessions for storing flash messages
  enable :sessions

  # Set the database URL
  set :database, 'sqlite3:bookstore.db'

  # Handle 404 errors
  not_found do
    'Page not found'
  end

  # Get all books
  get '/books' do
    @books = Book.all
    json @books
  end

  # Add a new book
  post '/books' do
    @book = Book.new(params)
    if @book.save
      json @book
    else
      status 400
    end
  end

  # Get a book by ID
  get '/books/:id' do
    @book = Book.find_by(id: params[:id])
    if @book
      json @book
    else
      status 404
    end
  end

  # Update a book by ID
  put '/books/:id' do
    @book = Book.find_by(id: params[:id])
    if @book.update(params)
      json @book
    else
      status 400
    end
  end

  # Delete a book by ID
  delete '/books/:id' do
    @book = Book.find_by(id: params[:id])
    if @book
      @book.destroy
      status 204
    else
      status 404
    end
  end

  # Add your other routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end
end

