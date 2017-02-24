
IMAGE = '/Users/jons/tech/projects/ruby/instaclone/spec/public/test.jpg'

def new_post
  click_link 'New post'
  attach_file('Image', IMAGE)
  fill_in 'Description', with: 'first photo'
  click_button 'post'
end

def sign_up
  click_link 'sign up'
  fill_in 'Email', with: 'test@test.com'
  fill_in 'Password', with: '12345678'
  fill_in 'Password confirmation', with: '12345678'
  click_button 'Sign up'
end

def user_seed
  before {User.create(email: 'test1@test.com', password: '12345678')}
end

def sign_in
  click_link 'sign in'
  fill_in 'Email', with: 'test1@test.com'
  fill_in 'Password', with: '12345678'
  click_button 'Log in'
end

def in_add_out
  sign_up
  new_post
  click_link 'sign out'
end
