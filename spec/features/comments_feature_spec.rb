require 'rails_helper'

feature 'comments' do
  before do
    visit '/photos'
    sign_up
    new_post
  end

  context 'no comments have been added to a photo' do
    scenario "A message to displaying 'no comments' should be shown" do
      expect(page).to have_content("No comments")
    end

    scenario 'comments can be added to a post' do
      add_comment
      expect(page).to have_current_path('/photos')
    end
  end

  context 'comments have been added to a post' do
    before do
      add_comment
    end

    scenario 'Comment should contain poster email' do
      expect(page).to have_content("test@test.com")
    end

    scenario 'Comment should contail message' do
      expect(page).to have_content("test comment")
    end
  end
end