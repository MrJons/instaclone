class Comment < ApplicationRecord
  belongs_to :photo
  belongs_to :user, optional: true

  validates :body, length: { minimum: 2 }
  validates :user_id, presence: true
end
