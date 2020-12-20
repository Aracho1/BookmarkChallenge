feature 'Tags' do
  scenario 'user can create a new tag' do
    visit '/bookmarks'
    click_button 'Create a new tag'
    expect(page).to have_field('tag')
    expect(page).to have_button('Submit')
  end
end