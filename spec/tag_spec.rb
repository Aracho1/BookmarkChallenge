require 'tag'

describe 'Tag' do
  it 'has an id and content' do
    new_tag = Tag.new(1, 'coding')
    expect(new_tag.id).to eq 1
    expect(new_tag.content).to eq 'coding'
  end
end