class Photo < ApplicationRecord
  has_attached_file :image, styles: { large: "500x500>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :image, presence: true

  has_many :comments, dependent: :destroy
  belongs_to :user
  acts_as_votable
end
