feature 'adding bookmark' do
  scenario 'have add bookmark button' do
    visit '/bookmarks'
    expect(page).to have_button 'Add Bookmark'
  end

  scenario 'add bookmark via form' do
    visit '/bookmarks'
    click_button "Add Bookmark"
    fill_in "title", with: 'Asos'
    fill_in 'url', with: 'www.asos.com'
    click_button "Add"
    expect(page).to have_content "Asos"
    # expect(page).not_to have_content "www.asos.com"
  end
end
