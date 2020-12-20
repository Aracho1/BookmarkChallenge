require 'comment'

describe 'Comment' do
  it "is linked to a bookmark id" do
    comment = Comment.new(id: 1, bookmark_id: 1, comment: "it's a great website")
    expect(comment.bookmark_id).to eq 1
    expect(comment.comment).to eq "it's a great website"
  end
end