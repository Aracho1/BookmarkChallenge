feature 'adding bookmark' do
  scenario 'have add bookmark button' do
    visit '/bookmarks'
    expect(page).to have_button 'Add Bookmark'
  end

  scenario 'adding bookmarks' do
    visit '/bookmarks/new'
    fill_in "title", with: 'Asos'
    fill_in 'url', with: 'www.asos.com'
    click_button "Add"
    expect(page).to have_link("Asos", href: 'www.asos.com')
  end
end
