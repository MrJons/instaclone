require 'rails_helper'

feature 'photos' do

  context 'no photos have been added' do
    scenario 'A message to promp uploads should be shown' do
      visit '/photos'
      expect(page).to have_content("There's no photos... add one?")
    end

    scenario 'A link to add photos should be visible' do
      visit '/photos'
      expect(page).to have_link('New post')
    end
  end

  context 'can be added' do
    scenario 'by clicking on the new post link' do
      visit '/photos'
      new_post
      expect(page).to have_current_path('/photos')
      expect(page).to have_content('first photo')
      expect(page).to have_css("img[src*='test.jpg']")
    end

    scenario "and the 'no photo' prompt should now not show" do
      visit '/photos'
      new_post
      expect(page).not_to have_content("There's no photos... add one?")
    end
  end

  context 'photo can be opened on seperate page' do
    scenario 'by clicking on photo' do
      visit '/photos'
      new_post
      click_link 'Show'
      photo_id = page.find(".photo")[:id]
      expect(page).to have_current_path('/photos/' + photo_id)
      expect(page).to have_content('first photo')
      expect(page).to have_css("img[src*='test.jpg']")
    end
  end
end
