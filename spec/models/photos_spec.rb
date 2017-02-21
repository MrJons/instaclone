require 'rails_helper'

describe Photo, type: :model do
  it 'is not valid without a attached image' do
    photo = Photo.new(image: nil)
    expect(photo).not_to be_valid
  end
end
