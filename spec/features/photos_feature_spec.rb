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
end
