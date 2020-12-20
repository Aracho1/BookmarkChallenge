require_relative 'database_connection'

class Tag
  attr_reader :id, :content

  def initialize(id, content)
    @id = id
    @content = content
  end

  def self.add(content)
    result = DatabaseConnection.query("INSERT INTO tags (content) VALUES('#{content}') RETURNING id, content")
    Tag.new(result[0]['id'], result[0]['content'])
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM tags")
    result.map { |tag| Tag.new(tag['id'], tag['content']) }
  end
end