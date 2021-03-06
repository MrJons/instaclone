require 'rails_helper'

feature 'comments' do
  before do
    visit '/photos'
    sign_up
    new_post
  end

  context 'no comments have been added to a photo' do
    scenario "A message displaying zero comments should be shown" do
      comment_counter = find_by_id('comment-post')
      expect(comment_counter).to have_content(0)
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

    scenario 'Comment can be deleted by user' do
      expect(page).to have_content("test comment")
      click_link 'comment-delete'
      expect(page).not_to have_content("test comment")
    end
  end

  context 'the delete cross is not visible to' do
    user_seed
    scenario 'a user that is not signed in' do
      add_comment
      click_link 'sign out'
      expect(page).not_to have_link('comment-delete')
    end

    scenario 'a user who is not the owner of the comment' do
      add_comment
      click_link 'sign out'
      sign_in
      expect(page).not_to have_link('comment-delete')
    end
  end

end
