class Gossip < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :tag_gossips
  has_many :tags, through: :tag_gossips

  validates :title, length: { in: 3..15}
  validates :content, presence: true
end
