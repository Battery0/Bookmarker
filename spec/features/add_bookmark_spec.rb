feature 'user can add a new bookmark to the list' do
  scenario 'add new bookmark' do
    visit('/bookmarks')
    click_button('Add Bookmarks')
    fill_in('url', with: 'http://www.google.com/')
    fill_in('title', with: 'Google')
    click_button('Add to List')
    expect(page).to have_content('Google')
  end
end