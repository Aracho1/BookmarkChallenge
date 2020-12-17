require 'bookmark'
require 'database_helpers'

describe Bookmark do
    it 'returns a list of bookmarks' do
        bookmark = Bookmark.add(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
        persisted_data = persisted_data(id: bookmark.id)

        expect(bookmark).to be_a Bookmark
        expect(bookmark.id).to eq persisted_data['id']
        expect(bookmark.title).to eq 'Test Bookmark'
        expect(bookmark.url).to eq 'http://www.testbookmark.com'
    end

    it 'deletes a bookmark' do
        bookmark = Bookmark.add(title: 'Makers Academy', url: 'http://www.makersacademy.com')
        Bookmark.delete(id: bookmark.id)
        expect(Bookmark.all.length).to eq 0
    end
end
