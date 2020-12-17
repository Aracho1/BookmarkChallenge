feature 'viewing bookmarks' do
  scenario 'shows bookmarks at /bookmarks' do
    visit('/bookmarks')
    click_button('Add Bookmark')
    fill_in 'title', with: 'Makers'
    fill_in 'url', with: "http://makers.com"
    click_button('Add')
    expect(page).to have_content 'Makers'
  end
end
