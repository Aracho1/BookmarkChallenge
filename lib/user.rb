require 'bcrypt'
require_relative 'database_connection'

class User

  # def password(password)
  #   @password ||= BCrypt::Password.create(password)
  # end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
  end
  
  def create(username, password)
    hashed_password = BCrypt::Password.create(password)
    DatabaseConnection.query("INSERT INTO users(username, password) VALUES('#{username}', '#{hashed_password}'")
  end

  def login
    @user = User.find(params[:username])
    if @user.password == params[:password]
      give_token
    else
      redirect '/bookmarks'
    end
  end
end