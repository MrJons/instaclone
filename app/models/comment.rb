class Comment < ApplicationRecord
  belongs_to :photo
  belongs_to :user, optional: true
end
