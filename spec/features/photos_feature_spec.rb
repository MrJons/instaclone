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

  context 'can be added - when logged in' do
    before :each do
      visit '/photos'
      sign_up
      new_post
    end

    scenario 'by clicking on the new post link' do
      expect(page).to have_current_path('/photos')
      expect(page).to have_content('first photo')
      expect(page).to have_css("img[src*='test.jpg']")
    end

    scenario "and the 'no photo' prompt should now not show" do
      expect(page).not_to have_content("There's no photos... add one?")
    end
  end

  context 'photo can be opened on seperate page' do
    scenario 'by clicking on photo (even when not logged in)' do
      visit '/photos'
      sign_up
      new_post
      click_link 'Show'
      photo_id = page.find(".photo")[:id]
      expect(page).to have_current_path('/photos/' + photo_id)
      expect(page).to have_content('first photo')
      expect(page).to have_css("img[src*='test.jpg']")
    end
  end

  context "can be edited - when logged in" do
    before :each do
      visit '/photos'
      sign_up
      new_post
    end

    scenario 'by clicking on edit link' do
      click_link 'Edit'
      fill_in 'Description', with: 'edited description'
      click_button 'post'
      expect(page).not_to have_content('first photo')
      expect(page).to have_content('edited description')
      expect(page).to have_css("img[src*='test.jpg']")
    end
  end

  context 'can be deleted - when logged in' do
    before :each do
      visit '/photos'
      sign_up
      new_post
    end

    scenario 'by clicking on delete link' do
      click_link 'Delete'
      expect(page).not_to have_content('first photo')
      expect(page).not_to have_css("img[src*='test.jpg']")
    end
  end

  context 'when not logged in' do
    scenario "trying to add a new post redirects to log in page" do
      visit '/photos'
      click_link 'New post'
      expect(page).to have_current_path('/users/sign_in')
    end

    scenario "trying to edit a post redirects to log in page" do
      visit '/photos'
      in_add_out
      click_link 'Edit'
      expect(page).to have_current_path('/users/sign_in')
    end

    scenario "trying to delete a post redirects to log in page" do
      visit '/photos'
      in_add_out
      click_link 'Delete'
      expect(page).to have_current_path('/users/sign_in')
    end
  end
end
