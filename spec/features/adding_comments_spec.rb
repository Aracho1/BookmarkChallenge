feature "comments" do
  scenario "user can add comments to each bookmark" do
    visit '/bookmarks'
    expect(page).to have_field('Add a comment')
  end
end