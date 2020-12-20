require 'pg'
require_relative 'database_connection'
require_relative 'comment'
require_relative 'tag'

class Bookmark
  attr_reader :id, :title, :url, :comments

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def self.add(url:, title:)
    return false unless is_url?(url)
    result = DatabaseConnection.query("INSERT INTO bookmarks (title, url) VALUES('#{title}', '#{url}') RETURNING id, title, url;")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  
  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM comments WHERE bookmark_id=#{id}")
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.edit(id:, url:, title:)
    return false unless is_url?(url)
    result = DatabaseConnection.query("UPDATE bookmarks SET url='#{url}', title='#{title}' WHERE id=#{id} RETURNING id, url, title;")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])

  end

  def self.find(id: )
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id};")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.add_comment(bookmark_id:, comments:)
    result = DatabaseConnection.query("INSERT INTO comments (text, bookmark_id) VALUES('#{comments}', '#{bookmark_id}') RETURNING id, text, bookmark_id")
    Comment.new(id: result[0]['id'], comment: result[0]['text'], bookmark_id: result[0]['bookmark_id'])
  end

  def comments
    result = DatabaseConnection.query("SELECT * FROM comments where bookmark_id = '#{self.id}'")
    result.map do |comment|
      Comment.new(id: comment['id'], comment: comment['text'], bookmark_id: comment['bookmark_id'])
    end
  end

  def self.add_tag(bookmark_id:, tag_id:)
    DatabaseConnection.query("INSERT INTO bookmark_tags (bookmark_id, tag_id) VALUES('#{bookmark_id}', '#{tag_id}') RETURNING id, bookmark_id, tag_id")
  end

  def tags 
    result = DatabaseConnection.query("SELECT * FROM bookmark_tags where bookmark_id = '#{self.id}'")
    result.map do |tag|
      DatabaseConnection.query("SELECT content FROM tags where id = '#{tag['tag_id']}'")[0]['content']
    end
  end

  def self.sort_by_tag(tag_id:)
    result = DatabaseConnection.query("SELECT bookmark_id FROM bookmark_tags where tag_id = '#{tag_id}'")
    result.map do |bookmark|
      bookmark = DatabaseConnection.query("SELECT * FROM bookmarks where id = #{bookmark['bookmark_id']}")[0]
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  private

  def self.is_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

end
