
IMAGE = '/Users/jons/tech/projects/ruby/instaclone/spec/public/test.jpg'

def new_post
  click_link 'New post'
  attach_file('Image', IMAGE)
  fill_in 'Description', with: 'first photo'
  click_button 'post'
end
