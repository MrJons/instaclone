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

    scenario 'posters email should be given' do
      poster_id = find_by_id('poster_id')
      expect(poster_id).to have_content('test@test.com')
    end

    scenario "and the 'no photo' prompt should now not show" do
      expect(page).not_to have_content("There's no photos... add one?")
    end
  end

  context "can be edited - when logged in" do
    before :each do
      visit '/photos'
      sign_up
      new_post
    end

    scenario 'by clicking on edit link' do
      click_link 'edit-post'
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
      click_link 'delete-post'
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

    scenario "there should be no edit button on a post" do
      visit '/photos'
      in_add_out
      expect(page).not_to have_link('edit-post')
    end

    scenario "there should be no delete button on a post" do
      visit '/photos'
      in_add_out
      expect(page).not_to have_link('delete-post')
    end
  end

  context 'when not the owner of a post' do
    user_seed
    scenario "there should be no edit button on a post" do
      visit '/photos'
      in_add_out
      sign_in
      expect(page).not_to have_link('edit-post')
    end

    scenario "there should be no delete button on a post" do
      visit '/photos'
      in_add_out
      sign_in
      expect(page).not_to have_link('delete-post')
    end
  end
end
