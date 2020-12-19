feature "updating bookmarks" do
  scenario "user can amend existing bookmarks" do
    visit('bookmarks')
    click_button('Add Bookmark')
    fill_in 'title', with:'Aamazon'
    fill_in 'url', with:'http://www.amazon.com'
    click_button('Add')
    click_button('Edit')
    expect(page).to have_field('title')
    expect(page).to have_field('url')
  end
end