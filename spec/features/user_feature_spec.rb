require 'rails_helper'

feature 'users' do

  context 'not signed in' do
    scenario 'can see sign in/up links on home page' do
      visit '/photos'
      expect(page).to have_link('sign in')
      expect(page).to have_link('sign up')
    end

    scenario 'cannot see sign out link' do
      visit '/photos'
      expect(page).not_to have_link('sign out')
    end

    # scenario 'can sign up/in' do
    #   visit '/photos'
    #   sign_up
    #   expect(page).to have_current_path('/photos')
    #   expect(page).to have_content('Signed up successfully.')
    # end
  end
  #
  # context 'when signed in' do
  #   before :each do
  #     visit '/photos'
  #     sign_up
  #   end
  #
  #   scenario 'can see sign out link' do
  #     puts current_user
  #     expect(page).to have_link('sign out')
  #   end
  #
  #   scenario 'cannot see sign up/in links' do
  #     expect(page).not_to have_link('sign up')
  #     expect(page).not_to have_link('sign in')
  #   end
  #
  #   # scenario 'can sign out' do
  #   #   click_link 'sign out'
  #   #
  #   # end
  # end
end
