feature "deleting bookmarks" do
  scenario "user can delete a bookmark" do
    Bookmark.add(url: "http://asos.com", title: 'Asos')
    visit('/bookmarks')
    expect(page).to have_link('Asos', href: 'http://asos.com')

    first('.bookmark').click_button 'Delete'
    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Asos', href: 'http://asos.com')
  end
end