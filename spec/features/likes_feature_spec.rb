require 'rails_helper'

feature 'likes' do

  before do
    visit '/photos'
    sign_up
    new_post
  end

  context 'no likes have been added to post' do

    let(:counter) { find_by_id('like-post') }

    scenario "button to add likes is present" do
      expect(page).to have_link('like-post')
    end

    scenario "like counter shows 0 likes" do
      expect(counter).to have_content(0)
    end

    scenario 'post can be liked' do
      click_link 'like-post'
      expect(counter).to have_content(1)
    end
  end

end
