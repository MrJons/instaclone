
def new_post
  click_link 'New post'
  attach_file('Image', '/Users/jons/tech/projects/ruby/instaclone/spec/public/test.jpg')
  fill_in 'Description', with: 'first photo'
  click_button 'post'
end
