feature "comments" do
  scenario "user can add comments to each bookmark" do
    bookmark = Bookmark.add(url: 'http://makersacademy.com', title:'Makers Academy')
    visit '/bookmarks'

    first('.bookmark').fill_in 'comment', with: "a great website"
    click_button 'Submit'
    expect(page).to have_content "a great website"
  end
end