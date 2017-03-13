require 'rails_helper'

describe Photo, type: :model do
  it 'is not valid without a attached image' do
    photo = Photo.new(description: 'post without image')
    expect(photo).not_to be_valid
    expect(photo.errors.messages[:image]).to include("can't be blank")
  end

  it 'is valid with an attached image' do
    photo = Photo.new(image: File.new(IMAGE))
    expect(photo).to be_valid
  end
end
