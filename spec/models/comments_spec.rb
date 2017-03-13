require 'rails_helper'

describe Comment, type: :model do
  before(:all) do
    @photo = Photo.new(image: File.new(IMAGE))
  end

  it 'is not valid if under 2 characters' do
    comment = @photo.comments.new(body: 'x')
    expect(comment).not_to be_valid
    LENGTH_VALIDATION = "is too short (minimum is 2 characters)"
    expect(comment.errors.messages[:body]).to include(LENGTH_VALIDATION)
  end

  it 'is not valid without a user id' do
    comment = @photo.comments.new(body: 'ab')
    expect(comment).not_to be_valid
    expect(comment.errors.messages[:user_id]).to include("can't be blank")
  end

  it 'to be valid with 2 or more characters & user id' do
    USER_TEST_ID = '1'
    comment = @photo.comments.new(body: 'ab', user_id: USER_TEST_ID)
    expect(comment).to be_valid
  end
end
