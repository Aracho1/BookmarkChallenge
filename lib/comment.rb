class Comment 
  attr_reader :id, :bookmark_id, :comment

  def initialize(id: id, bookmark_id: bookmark_id, comment: comment)
    @id = id
    @bookmark_id = bookmark_id
    @comment = comment
  end

end