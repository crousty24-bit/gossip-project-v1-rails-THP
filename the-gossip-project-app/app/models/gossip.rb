class Gossip < ApplicationRecord
  belongs_to :user
  has_many :join_table_gossip_tags
  has_many :tags, through: :join_table_gossip_tags
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
  validates :title, presence: true, length: { minimum: 3, maximum: 14 }
  validates :content, presence: true
end
