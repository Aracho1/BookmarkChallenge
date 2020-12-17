feature "updating bookmarks" do
  scenario "user can amend existing bookmarks" do
    visit('bookmarks')
    click_button('Add Bookmark')
    fill_in 'title', with:'Aamazon'
    fill_in 'url', with:'amazon.co.uk'
    click_button('Add')
    expect(page).to have_button('Edit')
  end
end