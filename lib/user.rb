require 'bcrypt'
require_relative 'database_connection'

class User
  include BCrypt
  attr_reader :id, :username, :password_hash

  def initialize(id:, username:, password:)
    @id = id
    @username = username
    @password_hash = password
  end
  
  def self.create(username, password)
    password_hash = Password.create(password)
    DatabaseConnection.query("INSERT INTO users(username, password) VALUES('#{username}', '#{password_hash}')")
  end

  def self.find(username)
    result = DatabaseConnection.query("SELECT * FROM users WHERE username='#{username}'")
    if result.count.zero? 
      return nil
    else
      User.new(id: result[0]['id'], username: result[0]['username'], password: result[0]['password'])
    end
  end

  def self.authenticate(username, password)
    user = find(username)
    return nil unless user
    return nil unless user.password == password
    user
  end

  def password
    @password ||= Password.new(password_hash)
  end

end